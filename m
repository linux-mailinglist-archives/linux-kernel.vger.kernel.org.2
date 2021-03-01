Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7383E328019
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhCAN4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:56:25 -0500
Received: from z11.mailgun.us ([104.130.96.11]:25168 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235941AbhCAN4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:56:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614606953; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5chAGnRHCOOOUrB3J0BqyQXRH/pOl11LjS7ONh8V23k=;
 b=M3GpvyDhj0+zhOag0Qbx7gHLstff+XtfntPjhqjCKs2HH4qiiyek6QDgWs//fFYyfnxfUbJP
 Xbj1uHjIqt6lqTx9JKZj+MY+ux3RXTbXiM4IH3yXPFvZBRQUGbsQMzGePQbV+z/PzorxbO6w
 6scriq3BiaLhdiWH7akZTq6kb8Q=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 603cf26475e4458f08af570b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Mar 2021 13:55:48
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E555BC43461; Mon,  1 Mar 2021 13:55:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43ABDC433C6;
        Mon,  1 Mar 2021 13:55:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Mar 2021 19:25:47 +0530
From:   pintu@codeaurora.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, jaewon31.kim@samsung.com,
        yuzhao@google.com, shakeelb@google.com, guro@fb.com,
        mchehab+huawei@kernel.org, xi.fengfei@h3c.com,
        lokeshgidra@google.com, hannes@cmpxchg.org, nigupta@nvidia.com,
        famzheng@amazon.com, andrew.a.klychkov@gmail.com,
        bigeasy@linutronix.de, ping.ping@gmail.com, vbabka@suse.cz,
        yzaikin@google.com, keescook@chromium.org, mcgrof@kernel.org,
        corbet@lwn.net, pintu.ping@gmail.com
Subject: Re: [PATCH] mm: introduce clear all vm events counters
In-Reply-To: <20210301121342.GP2723601@casper.infradead.org>
References: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
 <20210301121342.GP2723601@casper.infradead.org>
Message-ID: <38eb8e74f10a9ca0b7e390223edb9b91@codeaurora.org>
X-Sender: pintu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-01 17:43, Matthew Wilcox wrote:
> On Mon, Mar 01, 2021 at 04:19:26PM +0530, Pintu Kumar wrote:
>> +EXPORT_SYMBOL_GPL(clear_all_vm_events);
> 
> What module uses this function?

oh sorry, I will remove the EXPORT
Thanks for the review.


Regards,
Pintu
