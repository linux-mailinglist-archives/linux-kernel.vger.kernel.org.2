Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2F359983
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhDIJmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:42:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23321 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232087AbhDIJmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:42:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617961330; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WpUzTrF75CFjPqaMZHfNxdhRT2Sjbky/ud3Oa0xNKO0=; b=Xc0gtbzUJn0unPwudfXQ2/H71d+OlR0Jn/9uFh7PzzKnSoyvK5UFyGipgjJ+90cdGt25uJ9t
 QWtgFx4/ulTxYPpH9IxIg6Ib+8Rw79Zmg2MZuzrNgkAGRzU0FwRxOZgMCr5jhadgMypanQCt
 9i/dsNeZ42SEjV4i02wfBDqjXAE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6070215f9a9ff96d95107dde (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Apr 2021 09:41:51
 GMT
Sender: hangl=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ABFB9C433CA; Fri,  9 Apr 2021 09:41:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hangl-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hangl)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F540C433CA;
        Fri,  9 Apr 2021 09:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F540C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hangl@codeaurora.org
From:   Hang Lu <hangl@codeaurora.org>
To:     tkjos@google.com, gregkh@linuxfoundation.org
Cc:     tkjos@android.com, maco@android.com, arve@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, Hang Lu <hangl@codeaurora.org>
Subject: [PATCH 0/2] binder: tell userspace to dump current backtrace when detected oneway spamming
Date:   Fri,  9 Apr 2021 17:40:44 +0800
Message-Id: <1617961246-4502-1-git-send-email-hangl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add feature for binder oneway spamming detection, which tells userspace
to dump current backtrace. Fix the missing "BR_FROZEN_REPLY" issue first,
then features.

Hang Lu (2):
  binder: fix the missing BR_FROZEN_REPLY in binder_return_strings
  binder: tell userspace to dump current backtrace when detected oneway
    spamming

 drivers/android/binder.c            | 30 ++++++++++++++++++++++++++----
 drivers/android/binder_alloc.c      | 15 ++++++++++++---
 drivers/android/binder_alloc.h      |  8 +++++++-
 drivers/android/binder_internal.h   |  6 +++++-
 include/uapi/linux/android/binder.h |  8 ++++++++
 5 files changed, 58 insertions(+), 9 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

