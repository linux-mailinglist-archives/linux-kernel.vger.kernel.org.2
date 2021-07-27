Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7543D6C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 05:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhG0ChK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 22:37:10 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:43655 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhG0ChJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:37:09 -0400
Received: by mail-pj1-f52.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso2947243pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 20:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9DGKRhToYS2sW34sjXCQyf23ZBP6PkgJdOwYDPEaT90=;
        b=pgt5Dk47liDqvxwRdwGkUt7DPq4XGFHW+5FV605rOr67x40EV58c0fF/GP515S1Eoo
         UKSZiALIuXRGo6OyEHreU32GmKaQjNJfLQ9zqDYiw4KYTMHWShrugU//mXD8Qyg2OjJk
         anRm9yS4Wq+MEO3i4McYuGMhmiTR0u2deKktekaZGEUqzrujcSMcaf3xFJZ/+BEKHcmI
         LCqTqLgMStjMsraFBDDvAG30wcwbxKRT2yhH3Y9iJq9Q9aZP8WtIDGRh5NPt3Aj8M2A1
         GT5oOkvxNQ8FjkEES/JlZlQjDXtZ1upQIzVZQkj+1fRSllDWL9jbEEsULmctlBntoHbz
         cHtQ==
X-Gm-Message-State: AOAM531Su3NrD323VJJJ9+6yOgI0l3eIjcay71aRJZkACmKKf3Q4vQvx
        a8KNggw5ss5a3sfDvD8cZBw=
X-Google-Smtp-Source: ABdhPJz84o4jW+wBb85RF6NFMW9qtZ31vXRYUojYlHqztrmDLPE/2hWCQF3up8dMmxwCKCd2MGl/Uw==
X-Received: by 2002:a17:90b:ed2:: with SMTP id gz18mr2065386pjb.184.1627355856153;
        Mon, 26 Jul 2021 20:17:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:d009:b5bd:a16e:1de3? ([2601:647:4000:d7:d009:b5bd:a16e:1de3])
        by smtp.gmail.com with ESMTPSA id l10sm1038263pjg.11.2021.07.26.20.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 20:17:35 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bodo Stroesser <bostroesser@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
 <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
 <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
 <618b2bdc-282b-0a1d-1fc5-020cf80d7a7e@acm.org>
 <c9cb1f3b-0b3b-c571-4a51-e647f3c1e90a@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ab190c50-8c87-b215-1432-056c81bcd656@acm.org>
Date:   Mon, 26 Jul 2021 20:17:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c9cb1f3b-0b3b-c571-4a51-e647f3c1e90a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 5:54 PM, Bodo Stroesser wrote:
> The new behavior can also cause trouble with existing store handlers.
> Example:
> The tcmu attribute files cmd_time_out and qfull_time_out just take a
> string containing the decimal formatted number of seconds of the
> timeout. Each number up to now had to be transferred in a single write.
> Assume the old value is 30 and we want to change to 19. If userspace
> writes byte by byte, you end up calling
> store(item, "1\0", 1) and then
> store(item, "19\9", 2).
> If these quick changes do not cause trouble in tcmu's scsi cmd handling,
> then think what happens, if userspace is interrupted between the two
> writes. Allowing to split the writes cause a loss of "atomicity".

From Documentation/filesystems/configfs.rst, for normal attributes:
"Configfs expects write(2) to store the entire buffer at once." In other
words, the behavior for partial writes is undocumented. My changes
preserve the behavior if a buffer is written in its entirety. I do not
agree that my changes can cause trouble for existing store handlers.

Bart.
