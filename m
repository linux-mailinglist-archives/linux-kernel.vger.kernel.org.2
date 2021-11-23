Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A225645AA15
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhKWRb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhKWRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637688498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rbwewLFsABuwwFA7Yf68+QvHaRv0OksbhJ5ANLDADx0=;
        b=Wpks/hwTHm/CoCcSAyoGaQFE3rccuYo5uG8vJyyGYvPj1g59OMvNO6TksOWS0Cj70D86OK
        hOUIynMutej5wBKigOa4pSbeOBYYyjfO/GaXSf/N8xCEkzlLgBCPhBnX1U/rLLUUGhD7Ki
        k3IBfwRvtRCXqJEJY4yYbgod0b8fc54=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-nswE7KRkN3Czf507jAtJ5w-1; Tue, 23 Nov 2021 12:28:17 -0500
X-MC-Unique: nswE7KRkN3Czf507jAtJ5w-1
Received: by mail-wm1-f72.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso3200843wmd.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rbwewLFsABuwwFA7Yf68+QvHaRv0OksbhJ5ANLDADx0=;
        b=Ergw4tY31y8JnprcNGz7PmPH4RrXXWMSpzDv+5Zikw+55u+7HU3KZ8qCn9nyKTwoz8
         W4bjPHxppE9B17oUmDzSCSDpr+5MZjSOP1xTcduaqZKVEGQIwLtojHtqXacbr6BFwKUh
         KERDmz3tEVHJ31Wxugf4xubqCJ1ndzHiCzMbw0uwNCvbMA+JPZlqlYirS1cyJ07SQjVf
         KyL4G0cmF90y8KVLaLzEIcFHcEC0b6HH0bNGb238JonjvHhvfpnJqRiiMZl7mN2sHb2/
         18MIrfYk/PJJzerNJdKhQshO51TrfQQCazLRRNuuNiRd+xLb2ZGMPLteCLiTKpE7SfhC
         Z/5w==
X-Gm-Message-State: AOAM5331GEMSGFv9s7xEASVkMO24pg61vLtJjc5NvfsoOrG4mi51Eo7i
        YO/iXhCz9vqOq+7XQ/FWp8WFShxr31wj0C4WdLVZu3/NBQ8IwP0biVaEUs1ihCQC3hycuGlOrnz
        CLN1HJjjim7gjadBA6qJiPv1X
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr4980351wmq.77.1637688496426;
        Tue, 23 Nov 2021 09:28:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkGcSDFJfJ/eExQMmeWAJzI8oQYUpvN8NFnVUgfIHLPXSuqBAOg/ZJ3gCDo+Vofun2YxFzkA==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr4980310wmq.77.1637688496191;
        Tue, 23 Nov 2021 09:28:16 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a17:4f01:3a16:ae0:112c:ba92])
        by smtp.gmail.com with ESMTPSA id p62sm1827353wmp.10.2021.11.23.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:28:15 -0800 (PST)
Date:   Tue, 23 Nov 2021 17:28:14 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/6] rcu/nocb: Create kthreads on all CPUs if "rcu_nocb="
 or "nohz_full=" are passed
Message-ID: <20211123172814.4rev7z45onxvjmy4@localhost.localdomain>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123003708.468409-5-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/11/21 01:37, Frederic Weisbecker wrote:
> In order to be able to (de-)offload any CPU using cpuset in the future,
> create a NOCB kthread for all possible CPUs. For now this is done only
> as long as the "rcu_nocb=" or "nohz_full=" kernel parameters are passed

Super nitpick! In subject and above sentence, "rcu_nocb=" is actually
"rcu_nocbs=", isn't it?

Feel free to ignore the noise, of course. :)

Best,
Juri

