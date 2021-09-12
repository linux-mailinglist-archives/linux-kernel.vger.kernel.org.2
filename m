Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285D7407EE0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhILRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhILRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 13:12:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80D6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 10:11:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id j12so12754788ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWdxUP+QTdSO6Q0WwPsIuyGqKmUL6RaLcD4w+eF8cAI=;
        b=FyfhAYhX1BLniqOU1LvoOCt2djW+wKb2RrgB1dCi9pl0dmNTkUZtOBrrXzB/tAlDwJ
         XwfRt14MXkIKMys9rL0udOGC8H9uyA+40Sboha8SSMqoVN0rDsbHIW4DGocvjPr/1ukO
         ivSPkXEuNecxInscs2CvndITV9Z2CzndKRkyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWdxUP+QTdSO6Q0WwPsIuyGqKmUL6RaLcD4w+eF8cAI=;
        b=2ew43gJgWYzC/iJzucTaca6hJ/KIh2TTexa0CIeBcX13D3xtthT72GFDnwFRKGZn/L
         l3S8KBTtznmAHGQU7HmDiqMc+mZ8gOWOIidHfn4YdBeMJbhydvoHAvsw2rjonpwYaq2H
         xE5giRa4OmICoV+AIKVV+CuSxXeHin0S3wTxwc2irKRMrm7fBeupEeTC7VXK6J4+Acmu
         Dg0v2X9FYqCbDgbHH99xSbPj/wasBya1G1CqSnw4z3aM6pXAbkqz3vsM0m74TPvwaNDB
         newUXBwi3ND1MZ1FnCnkTDWv2e417Pz0cFnYyVJyHnIG4wMDbQ5Z0IwRmpKbWGhoy3uB
         EIvA==
X-Gm-Message-State: AOAM531J0TPB0c2n8+1tTphjpOJNDsZkiJ8npHEKffZ5KbWoLAgMQiAJ
        JG+1OD0DvIjNkyIuCI5IRVRMwY2BUlOzWJjLRFM=
X-Google-Smtp-Source: ABdhPJzqpP7Tsp+sbbwzGCgKGdhbWq+lnJptgeapefWFfqlxET+5Yc/cGQ8z7QGKag2Y1/AQti3tgQ==
X-Received: by 2002:a05:651c:54e:: with SMTP id q14mr7120323ljp.152.1631466694789;
        Sun, 12 Sep 2021 10:11:34 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a15sm682708ljb.18.2021.09.12.10.11.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 10:11:34 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id g1so4376484lfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 10:11:33 -0700 (PDT)
X-Received: by 2002:a05:6512:3d04:: with SMTP id d4mr5879343lfv.474.1631466693700;
 Sun, 12 Sep 2021 10:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8Tbj+Jwo6pgM--fGtOBW3vyaSkU==959G=-HtoT5EzQ@mail.gmail.com>
In-Reply-To: <CAH2r5ms8Tbj+Jwo6pgM--fGtOBW3vyaSkU==959G=-HtoT5EzQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 10:11:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB4GpMc90JJ-Bp9iO7-q0Ci3N50EPx4D6etHnZ-eD2yw@mail.gmail.com>
Message-ID: <CAHk-=whB4GpMc90JJ-Bp9iO7-q0Ci3N50EPx4D6etHnZ-eD2yw@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 10:24 AM Steve French <smfrench@gmail.com> wrote:
>
>   git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2

Your pull request message was a mess - you'd done some odd
cut-and-paste with the automated output being mixed in six(!) times in
between some of your manual edits.

I tried to make a sensible merge message of it all.

           Linus
