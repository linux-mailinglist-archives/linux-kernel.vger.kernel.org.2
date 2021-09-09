Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17439405EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbhIIVMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhIIVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:12:05 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E938FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:10:55 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so1009058oon.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=oQs1XgPjDPgT6H3Vd8knRQ14vSHuHpiGCRbbwe0LZvQ=;
        b=VX/MNh37lB/TOF2EsWLTMiRYm5rg4KtKgmkK/biF3Db7NM6CqU0uvfpBStwM/Cskx4
         fFPKEgiyggTuTRx0tLIVu49fj68Djp0lH8BoL4nivqkVOaRQRnwRUieYifEDGJc1vNeD
         Dq42vHPkbnb9k5lIhWBxWb1PWY9dxmXARFYgUM+BATVr5l29ct3H+cclYlgQWWOl4Q4z
         ZD/KzUvDcfBeevqEOKNskY2otPr9d/0t2ADmpYmgCpoTM21h8Fl7HJhF6cKqDBLctgld
         BC2fo1Jb+E4lhZAE7tFQ9TJQK9gcXOenSboM8liX2MxuMON0Cv78Sch3HSc+oVXK+bv0
         o46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=oQs1XgPjDPgT6H3Vd8knRQ14vSHuHpiGCRbbwe0LZvQ=;
        b=tNYS4DtBjk1zhVvss7pphyhy7v/iwUodX7EHhWDZzt71n4TWeUsc6AxwWeoUiNKSl/
         rqzao80QikXSA5velUOAha3mxvf0qTuiNcgKHjnbH/Ogq1x12Y00N9BAgXzi1gk/aCWd
         1IdGZz7upz08ibqIFxUNWwFocegVTyxr8pn7JSAm7WCjEUtzsCW+d1rkqLl3zrwTh3zU
         x91JQ934jYRbLsWZsgsVBjulz5ptdLBzOKOzmw52ld8IckXWhTfYPE31VYQ4Q/Q9cquz
         mk/Kr+oi/DNXb2t2mj9a2KY5St87kmp0taTOIx/YkI9xCLKl67qayVT1MxWGaTDuPbLo
         76Sw==
X-Gm-Message-State: AOAM531eCLDocmuUrsXzPPsOuL8TPCnCMwY1ePxQTt0UWXS3b0j/lZ4p
        qHR/mQMQrDxwdedUX7lzHA==
X-Google-Smtp-Source: ABdhPJyKKIOrsEqQhxAHrZWxwo9221V8abvce2F//muuYtCv9kjbD77lMhtVz89ktaH2fAYFPhmgkw==
X-Received: by 2002:a4a:8f99:: with SMTP id c25mr1517255ooj.11.1631221855251;
        Thu, 09 Sep 2021 14:10:55 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id q5sm643790ooa.1.2021.09.09.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:10:54 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:615a:3062:83b4:c204])
        by serve.minyard.net (Postfix) with ESMTPSA id 558F11800ED;
        Thu,  9 Sep 2021 21:10:53 +0000 (UTC)
Date:   Thu, 9 Sep 2021 16:10:52 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.15
Message-ID: <20210909211052.GM545073@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

he following changes since commit 8baef6386baaefb776bdd09b5c7630cf057c51c6:

  Merge tag 'drm-fixes-2021-07-23' of git://anongit.freedesktop.org/drm/drm (2021-07-22 20:32:13 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.15-1

for you to fetch changes up to bf064c7bec3bfe7e28889774dc9e0ca4f7236775:

  char: ipmi: use DEVICE_ATTR helper macro (2021-08-12 14:27:52 -0500)

----------------------------------------------------------------
IPMI: A couple of very minor fixes for style and rate limiting

Nothing bug, but probably needs to go in.

----------------------------------------------------------------
Dwaipayan Ray (1):
      char: ipmi: use DEVICE_ATTR helper macro

Wen Yang (1):
      ipmi: rate limit ipmi smi_event failure message

 drivers/char/ipmi/ipmi_si_intf.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

