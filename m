Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E450319195
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhBKRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhBKRRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:17:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B262C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:17:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p21so9142411lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ntL0a2YXcEMfpZL1F+LXItXxrwxQQReBc+liSIu+3b4=;
        b=TIBR2o0gg/XWg5SbfTMzREP+L981MEcoYOtYK+mSlH+is3XllsLDAE4KhGtLOCouY9
         JUELH41Aw9QuLSlwHEygWTi54OjyQ9w+kv4e5Yqv5f9jYHEi8GKtGbo5tNw9XxAPbLJn
         s0LkCpf+oIn+RLzOEHXDi32qbZgt7ufDNAISmtThvq/zvoiTEGEAVjPLXc2Q6zIesfbk
         FTbOZ2gkkmTi3FK89Hr9pCEb1I+YZjH7+Cmlz0T842ThXs+3lY8Krz22gT+0H6efzKiI
         p/1t2pS3sy5PCBi4tzJZjT+u3fJbfLxjuTAPdL0es+3nFFHG8aj1ac+gtiv3Onj4YdYr
         q0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ntL0a2YXcEMfpZL1F+LXItXxrwxQQReBc+liSIu+3b4=;
        b=ehjO3fwkW/qgRLFXGvGsBixNf+QzE3fAC8DCp8hcHlhuEvK3YaoIC56Qd1nebmlBDa
         bFA7ipK4xpAWqIlw91dWnFLpoP/pg2o6XE8h+qdIAlVEWiLt/9gUMZjiTdIVGAEqN/vy
         zH50GTokY66zfBvSFwSEWYmZXJZ9nAI42qmu+uIT1Y47Rs73iyiMbzGndtNadNjQBfj9
         YeKmapJB1kP15Lmr4I9koFzz7ejyVeNYkV//1MjY49wbwOZmLhGV+um+G3irWUK3rTG6
         xhVsJYvd7RVNZPUEcyua240oGaZLAlbhZW5wnP8cBOuGDUSkXjNtP3S+F1K+9ir/lHHO
         BfYw==
X-Gm-Message-State: AOAM53201bHZPBhQktf7XaYd4D1ClWwKVymkZ0tnA8I2SQ2FBPfZu+cH
        sBV60uj2ZtWMqSy2mMOWiwlVdBkE7jjuE6ZfNqwjTZ+Tny3B3Q==
X-Google-Smtp-Source: ABdhPJylh09HTTtSH5F/14PPs+I0Pv/Zi61/3KVwU2/tBwKvujFXsfI701zKqu84Pa6ZnW3CKq7e/y7BH0cYzStBgzE=
X-Received: by 2002:a05:6512:3110:: with SMTP id n16mr4712532lfb.58.1613063827176;
 Thu, 11 Feb 2021 09:17:07 -0800 (PST)
MIME-Version: 1.0
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Thu, 11 Feb 2021 17:16:56 +0000
Message-ID: <CANVEwpb2oyYFbXkCaeuhnr0s1LH8ojf_WDoStcLYoB1eXWhgRw@mail.gmail.com>
Subject: objtool segfault in 5.10 kernels with binutils-2.36.1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 5.10 kernels up to and including 5.10.15 when trying to build the
kernel for an x86_64 skylake using binutils-2.36.1, gcc-10.2 and
glibic-2.33 I get a segfault in objtool if the orc unwinder is
enabled.

This has already been fixed in 5.11 by ''objtool: Fix seg fault with
Clang non-section symbols'
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?i=
d=3D44f6a7c0755d8dd453c70557e11687bb080a6f21

So can this be added to 5.10 stable, please ?

Please CC me as I am no-longer subscribed.

=C4=B8en
