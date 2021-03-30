Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C579D34EFA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhC3Req (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:34:46 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39527 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhC3Re3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:34:29 -0400
Received: by mail-ot1-f51.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so16342790ote.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XrptEghcxdTQZaRjcdwhLqUukJxpuPSRHJqpw6RjUr8=;
        b=GDl9JTd/gz4fwa1bajFAfIkGbDkxbG+knX59gbA7vFslgM36BJyNYJyA8k5uBC8qii
         em5OqVCaSNZVeXE6T9hK3N2WUmGq7bn0GOhQx4DLL6zUDLEn4YWjdtJkSYkWH1LKOecN
         XeQ2aq2QAXNXSRVukAngsmlNvPAujhIe5Ibt3ZZFUSGPvP5g+tiVtE0dVrWN/p+4If+m
         IAn8adtr4HGkgAbuc9ZArub2sYRD5cQ3uExOVyIAb3vxKPezjGw4VRGakZwYxwrEgkaX
         baMJNNm0RNVXQ8y0AJwgCE0573FbB+Rzf0C9USaxmLH/WyaqXnhQQLNXksu+8TD9p/wY
         7p8w==
X-Gm-Message-State: AOAM533TNM0ONnyemwU41tmho5aJt8NdIK0K1MCvahSxG1H17RNOAD8Y
        p4lXP+q2oJYOeJH9fXoZIAuvasWl4/0=
X-Google-Smtp-Source: ABdhPJzoD7nzNnMZFuWsajtjOZufvncEn1PPO7i9ZOw45Ndyjy+l4lecZmqXg25ZTHBMlwk/qyOQrQ==
X-Received: by 2002:a9d:62d8:: with SMTP id z24mr28019748otk.258.1617125668624;
        Tue, 30 Mar 2021 10:34:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:b4f0:c745:2568:3257? ([2600:1700:65a0:78e0:b4f0:c745:2568:3257])
        by smtp.gmail.com with ESMTPSA id d24sm5132266otf.12.2021.03.30.10.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 10:34:28 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
Date:   Tue, 30 Mar 2021 10:34:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> It is, but in this situation, the controller is sending a second
>> completion that results in a use-after-free, which makes the
>> transport irrelevant. Unless there is some other flow (which is
>> unclear
>> to me) that causes this which is a bug that needs to be fixed rather
>> than hidden with a safeguard.
>>
> 
> The kernel should not crash regardless of any network traffic that is
> sent to the system.  It should not be possible to either intentionally
> of mistakenly contruct packets that will deny service in this way.

This is not specific to nvme-tcp. I can build an rdma or pci controller
that can trigger the same crash... I saw a similar patch from Hannes
implemented in the scsi level, and not the individual scsi transports..

I would also mention, that a crash is not even the scariest issue that
we can see here, because if the request happened to be reused we are
in the silent data corruption realm...
