Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090F43510D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhDAI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:26:11 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:41749 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhDAIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:25:41 -0400
Received: by mail-pl1-f182.google.com with SMTP id g10so643851plt.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 01:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s9dXlyNB1wPFpzLt1/MDRCLJ2LvSrlsREvp75Ydv0AA=;
        b=tgWpMZ1s/xdaYI0iUGW2F/ltkXYif1QYNTrC50AzcWzymb5+jRTfandEfK3lhHZ3GH
         BLU/BleG8Tp6S9/MCgW0tPoh0IzzJzY623BxFSvg+bzl3+zvx87Y0LTh6VZjAUGTYrt+
         w+KoypdxywGviRQ4HTrqL1iHj5wwtuhOQ0UcsI3v/rNUqw0LTNbEFq8LarUkKciSmQGg
         U9f3GgIDNcKCilmvjhzLJ/oA/hasq/coHvxF8joMHRqhuxzGcqVM4bdhqbWfjZsTyNAU
         5wHrOvfVxbGJJLkxg0bS0EQT+pfLUiDjzKl6kJhdWlwKj0DkbS5m0GTIhqsckVYwD8kK
         OFfg==
X-Gm-Message-State: AOAM532CIH2bvYoe3ECg4jTm+2uG4BVZZu90SEzEFPBvCuL9eoj5hgF+
        4Hp6Zt0Kydefo8GXmNtpIMo=
X-Google-Smtp-Source: ABdhPJypesiR74AXgEtnLv9M+Fk//zNWcoI9lcBE8fzwq+6i9t5CK2XBU+no/s/OGJe/2tdvkAUTDg==
X-Received: by 2002:a17:90a:d3d8:: with SMTP id d24mr7883059pjw.28.1617265540755;
        Thu, 01 Apr 2021 01:25:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bf93:1a21:45ef:9cdc? ([2601:647:4802:9070:bf93:1a21:45ef:9cdc])
        by smtp.gmail.com with ESMTPSA id j21sm4070124pfc.114.2021.04.01.01.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 01:25:40 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
 <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
 <5715ef78-eaf1-dcb6-c2a2-f4725e1a01c4@grimberg.me>
 <20210401062031.GA25424@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8e93c5ce-aff7-ca0b-919c-a33eb0b9ceaf@grimberg.me>
Date:   Thu, 1 Apr 2021 01:25:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401062031.GA25424@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> request tag can't be zero? I forget...
> 
> Of course it can.  But the reserved tags are before the normal tags,
> so 0 would be a reserved tag for nvme.

Right.
