Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCDC3F6A86
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhHXUjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 16:39:16 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:36850 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbhHXUjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:39:09 -0400
Received: by mail-ed1-f43.google.com with SMTP id b7so33627096edu.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bj4G4Fv3K7qkrLB/46eXuh+KiEbZ4cq/4erNT5rDd0=;
        b=cuhg/B1vpnb783uCqC1OC+EQDpgWW538nHSLABys5nQQcJth52SbxcJoJBbW87W8cd
         5md0+9MBtP/PsyN1dD7cDbxk1mDjeN3Mdgr9jCag2Tj0haDYVTliEtt7+aYLoLmdwh5J
         quQzaPOs9IpAREa67djeU2M2Y5Riw9RZBEuRnQV7WX/gjJ0/ZLYCR9DPRqaDWxMsNwZl
         jS/hMnkxCdEXj/af3LD7j9m9FRe4EsUttUUNhURImIkWrbdB9yPgKNewxTDk0KN/sq2r
         mZzr74xDjW/KJbxDvES3/LQ1Icepca+asvi2NbndwlREpDmPHQ06YZkNEwunvrk41XUw
         4eag==
X-Gm-Message-State: AOAM533urbqkZh8ABcjRkSYd2kfpZi0cjWHIk38ttitihdGo6wU3OTwu
        60nBh39sXl+D2LOwJZFij/M=
X-Google-Smtp-Source: ABdhPJxeb6t+lJh7qnda3Z3KUzyz3sKfhEGA7TLQyQcnmVirqWp28zytteoDi8lIxNyn3a8+wM3VIw==
X-Received: by 2002:aa7:d842:: with SMTP id f2mr12940811eds.57.1629837504309;
        Tue, 24 Aug 2021 13:38:24 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il. [109.186.228.184])
        by smtp.gmail.com with ESMTPSA id be5sm1018543edb.57.2021.08.24.13.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 13:38:23 -0700 (PDT)
Subject: Re: [PATCH v6 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>
References: <20210823112351.82899-1-dwagner@suse.de>
 <20210823112351.82899-4-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <025942a6-4f57-b005-eb77-e9eed143522c@grimberg.me>
Date:   Tue, 24 Aug 2021 13:38:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823112351.82899-4-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: James Smart <jsmart2021@gmail.com>
> 
> Remove the freeze/unfreeze around changes to the number of hardware
> queues. Study and retest has indicated there are no ios that can be
> active at this point so there is nothing to freeze.
> 
> This patch primarily reverts 883837ed0f1f

Bogus commit ID.

  "nvme-fc: wait for queues to
> freeze before calling update_hr_hw_queues". It's not an exact revert as
> it leaves the adjusting of hw queues only if the count changes.

I see that fc doesn't freeze the queues, so it obviously wrong to
unfreeze them. But is it correct to not freeze the queues?
