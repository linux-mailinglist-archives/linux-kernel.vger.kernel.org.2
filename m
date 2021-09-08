Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05B40327C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347112AbhIHCKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347006AbhIHCKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:10:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87908C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 19:09:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so1683398lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 19:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMfhnZEDUobmgMhlgRrfI9FnzHQ5cBHWiHpC8dZfDL8=;
        b=PaytCRkY84O6DVS1dyHCT8Cfr2TXCcsOW8lD7RUZNnJhHuwUDUmbH8lDBBsT8S60wZ
         TrX2KvKSPjcbxEIdOWtmQs6VTGHmqiTLgkq/Pk/tZNUL+lEd1/5ClG0NwnwYDYmvPgqg
         8x2hDuO8nRlvlVXhOhFPNlqxephWBiaHokPOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMfhnZEDUobmgMhlgRrfI9FnzHQ5cBHWiHpC8dZfDL8=;
        b=mEoLY7CZ4rmv/zYFb/ui+R+T6bFj0QHtEyw0HcMrpgSr/Cn+WCKNVph0dTBNeCqF5R
         57xqNg9akych5GJBQKMtqVS1ThfAXxvln5fmePiNbYk4MXa0JJD3Ohi7kvta51ittM12
         HdYsavzGADPeKrDlzHveRriPUA/UHR/AH6S84FjgGEabdXOsTLaSlH7IUcNfprSztbU1
         MQdZjo2nhrXbHb37ZiB9RaaPhc2UsdtYvmm4cn0wq5kIvAcllDjlBV4A/imVxhBUcBzx
         FcZ8Y5AFIOz+HvVSs3Jw7ubH9Qvrnm8X2LWqlr+OZ2tJedkQmlTZSMseHFv6thdiNjlY
         6tLw==
X-Gm-Message-State: AOAM531AB23qaaA3a5ZzbgAK1e0BhGkLMLGQ3FzC/m810u2gs9tcMITV
        2hKW0RLnL/p8gF78SQWB58nKTY1Bsad7aKkeBos=
X-Google-Smtp-Source: ABdhPJwsOaHPVTce8cVMK4wg6HenIMbxjQWrU7fJ2VABqDDGi0gTriDlZhCmZ0Z8Pk2wM0vermw4Wg==
X-Received: by 2002:a19:f014:: with SMTP id p20mr967730lfc.589.1631066939246;
        Tue, 07 Sep 2021 19:08:59 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m4sm54266lfr.279.2021.09.07.19.08.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 19:08:59 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id w4so799563ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 19:08:58 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr867691ljp.494.1631066938338;
 Tue, 07 Sep 2021 19:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210907213943.GA822380@bjorn-Precision-5520>
In-Reply-To: <20210907213943.GA822380@bjorn-Precision-5520>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 19:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCgh_V-g74LE4pQKqakbiK+CM5opVtH1t2+Y3R=uH9EA@mail.gmail.com>
Message-ID: <CAHk-=wiCgh_V-g74LE4pQKqakbiK+CM5opVtH1t2+Y3R=uH9EA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.15
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 2:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c
>   drivers/net/ethernet/broadcom/bnx2.c
>     Fallout from the VPD changes below.  These include both PCI core and
>     driver changes, and the driver changes got merged via the net tree and
>     then reverted so everything would be merged via the PCI tree.

Christ.

So the revert from the networking tree has basically _zero_ useful
information. It just says "revert".

David, that's not ok. The natural reaction to this situation is

  "ok, this commit was done both in the networking tree and the PCI
tree, but then the networking tree reverted it. So there must be
something wrong with it, and I should take the reverted state"

but Bjorn's comment implies that it was reverted in order to _avoid_
merge conflicts since it was also done in the PCI tree, which is pure
and utter garbage, because I end up with the merge conflict *ANYWAY*
due to the other changes, and now instead of going "ok, the PCI tree
had that same commit, all good", I have to go "ok, so the PCI tree had
the same commit, but it was reverted in the networking tree, so now I
have both sides making different changes and a very confusing merge".

Here's the thing. There's a couple of very simple and basic rules:

 (a) don't do stupid things. In particular, don't try to make my
merges easier by adding MORE crap on top of the known merge problem.

     This is not that different from "don't rebase merge conflicts
away". You're making things worse.

 (b) INDEPENDENTLY of that "don't do stupid things", the #1 rules for
_any_ commit is to give the damn reason for the commit.

     You can't just say "revert X" in a commit message. That's not a
reason. That doesn't explain ANYTHING at all.

So now I have to basically guess at what is going on.

Yes, yes, I can make fairly informed guesses from looking more
carefully at the code, looking at the *other* commit messages, and
doing something sensible. So my guesses aren't going to be about
tossing a coin. But please don't do these kinds of things!

Don't make my life "easier" by doing stupid things, and DO put a
reason for every single commit you do. Reverts aren't "oh, I'm just
turning back the clock, so no reason to say anything else".

          Linus
