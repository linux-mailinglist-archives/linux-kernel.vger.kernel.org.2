Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2A4175D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346502AbhIXNd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346457AbhIXNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:33:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A379C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:25:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 73so28068858qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=pQvFc08SgO33pAo1wxhZmDdsnyFna10/RsiuhV/c7LI=;
        b=pti813zI1CLo0h1SJ6O4OjJF322ABZ3RdZjzbYXyktom3egNLbEOnYw18VhrCGm9xl
         Ey8RAK/KjaYRxWdjvlYa2hRAb3sXf+fvx+ERkDRWfusnD55+FkE2RZ3ZB0aOv8bia+tJ
         du83ahXwsf1Jjz3CQD0oU/Bm2WcPBzqH1s+Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=pQvFc08SgO33pAo1wxhZmDdsnyFna10/RsiuhV/c7LI=;
        b=LBUq/mFffDlSh858jPHsXmnfZPRH8CvpaIuOd+ogJBW3s3194bEueiPWLU7IBKOYzK
         dEN2/S9ejco7KZSS+a1S0P0UV6GJLQQJx21Gu99RLIsHC+RnXWSGHxEWXgtLiCDgql+O
         onXFZ3H7+mgbpM3IOWQH8hL55CWlmPp98vXw1uBaaPu6HKGnSeqy9yVw7IpzPCpWxv6q
         JRy+NtL6JlzCuFMRvVwXOBBE5Pwrz/+0TBReMlkZqFQAJTWL8Dg7AXyhdMmcEtFIRC9b
         t2xaIvUR2mQyzkvW8hQ24DWbJ85i00qF69NujO5GNBhYjewR/EHX0ntZr479HTDVVB36
         l51w==
X-Gm-Message-State: AOAM5304ZtrYTbo/pnm+S5yiReLuJQRgvmQg+rFfuv4JkJmS57m/aT+D
        7v+HGPzGwu5+3J9FxoEw7AgiyfbnnE2K4g==
X-Google-Smtp-Source: ABdhPJy4TyAdVj7FxpEMlr4A3iKLcg48ZTwphH7LY6DCOfqGFRa7tLVZLIU1chHveaPiYqlT6QzQnA==
X-Received: by 2002:a05:620a:a96:: with SMTP id v22mr10082094qkg.353.1632489920390;
        Fri, 24 Sep 2021 06:25:20 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id g19sm6202887qki.58.2021.09.24.06.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:25:20 -0700 (PDT)
Message-ID: <6e307861-3149-a984-cc79-088559caeab2@labbott.name>
Date:   Fri, 24 Sep 2021 09:25:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     ksummit@lists.linux.dev,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
From:   Laura Abbott <laura@labbott.name>
Subject: Results from the 2021 Linux Foundation Technical Advisory Board
 election
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This year's election for the Linux Foundation Technical Advisory
Board had 1012 authorized voters; 237 of them cast ballots.
The results were:

1. Greg-KH
2. Jonathan Corbet
3. Steven Rostedt
4. Theodore Ts'o
5. Sasha Levin
---
6. Dave Hansen
7. Kent Overstreet
8. Dave Taht

The top five will serve two-year terms on the TAB.

Thank you to all the candidates for their nominations and to everyone
for voting.

If you have any questions please reach out to
tab-elections@lists.linuxfoundation.org

Thanks,
Laura
