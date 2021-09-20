Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C37E4119A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbhITQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbhITQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:20:38 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF48C0617BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:16:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id u21so16065074qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c4p5LbkR5a+CTH/BlqAWrzithBt0LPedNw7Pvp2S/4w=;
        b=NJbdoEpOILdc7PCD5CLz6Lo0UQA5nD5bIJI8Kwpcn2NXMcMV21OnOCD6dFnj7ol8aJ
         XvCHZTKOSAybnC9k5E9JDjtzL9AL4q46OowfAfC4QyMXxGi/f4izwZRr1j0lWy2JYQZQ
         YJVYsSGmynqwobOkBDlD8ElZzP3hssAQwEcJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c4p5LbkR5a+CTH/BlqAWrzithBt0LPedNw7Pvp2S/4w=;
        b=iovs0M7yr9Fkw73c5WwX+zCejjtxVRH0douc2SkRlanlJnl/z8YjRtIQimfOwLIz//
         a5Fz6CMlTHG/a3ev5vMSvc/1nMcOtXaX7bmxzzV5GaAU2EtcksMr0OJCmOOJJQ2WPMz8
         FFY+FugLsuSXl1BI8VwpNhV4ZFcMXr5LxVIVxpO/qteGk0TIDpRRkZ4SsITIL5KeMgWI
         qwRV3HX6IvTHzsHQS1wI4AQhi5/LPm67J53jEDD0VSljDx2V0C2JlB+xR4RApEfXmG5r
         3LYnelIihoa1koZqbmh1+tKNPlay80qgrOQ59+9iQRTfLCT4XfL4DHhowdzjnYw9pLX0
         qH+g==
X-Gm-Message-State: AOAM530KrtuRoSD6Pb+pct70ygYt6vPA9V7uqFnFwCnGA0kFOz90h7Fy
        0woUF9/YlXOpkgCT2dXhCkWeRg==
X-Google-Smtp-Source: ABdhPJzoTZVfJXvYP1AsCVp0osILJalwXxTdsOXGGyurRIZoG4UO9I5BbvuRVkJc6V8lXcMQk7vQ5A==
X-Received: by 2002:a05:622a:1451:: with SMTP id v17mr23386098qtx.83.1632154560414;
        Mon, 20 Sep 2021 09:16:00 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id l7sm4687975qtr.87.2021.09.20.09.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 09:16:00 -0700 (PDT)
Message-ID: <2917e393-0777-81c2-6a2d-5130c37cda06@labbott.name>
Date:   Mon, 20 Sep 2021 12:15:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [Tab-elections] IMPORTANT: CIVS opt-in for Technical Advisory
 Board voting
Content-Language: en-US
To:     Dave Hansen <dave@sr71.net>, ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
Cc:     "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
 <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 11:30, Dave Hansen wrote:
> My @linux.intel.com account is the most common one from the git logs.  I
> have only received one TAB-related email there:
> 
> 	Subject: Upcoming Technical Advisory Board election -- look for
> 		 your ballot
> 
> However, I never actually received a ballot at that email, presumably
> because of this CIVS opt-in issue.
> 
> Was this just me?  Or would it be appropriate to send these opt-in
> instructions to all of those that should have received a ballot instead
> of just sending to the mailing lists?

I did make an attempt to send a message to everyone on the voting list
(which should include your @linux.intel.com mail) in addition to posting
on the list. It's possible either my message ended up in spam or it
got throttled by gmail.

Thanks,
Laura
