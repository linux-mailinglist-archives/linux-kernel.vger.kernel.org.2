Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62D844B0F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhKIQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbhKIQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:18:16 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437FC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 08:15:27 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso2340516wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KXVd9m1NZmupPpCYn0b2KbapjdNKLJeqq2tr8Ng9LpA=;
        b=w2w2snsS/qJkUD/3vz6tZgLBbS70II3GGBCWkN+6RauKFRgP4LonXyr5lPdK/cXmMo
         xCV3BDhQy1dX5q22F9jw6JigwEVAhJGFNb7fcEMjK2fwN/TynXacZ0iv59d/oQZ5rTLQ
         SZGrV8EB5De+xzVVy3AKdZh7KgAO5fxnnMunXFZkeP/kEpnyaUBAZKuBw5SgxIcSnMlp
         igvgVQq4eivWwecAVJRHcQ+wNtxmtOKWEDvixp2Eue0QFnzIiUe2tyOkDfUgn2q4rRQA
         FtpMGtlnu521zqGdljvvT1nMHx8ua4hGFxLwjHe6NTan8oXizhriJYfxRTV/Ki3XVK+e
         ab9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KXVd9m1NZmupPpCYn0b2KbapjdNKLJeqq2tr8Ng9LpA=;
        b=cQ4LwBwXvoBj3EdGWRB+iUsbunSjWukA2XYVkv1I/UdoHR/MwmF79hdjQ+I6xTW51+
         IU5DVR/rHCqzJF8sbsrmaMmHviVajBBHwzun/40+Ui8LDc2pOEaGgjtHm28KUcyBEcoO
         8vtP33pQezGnpm0WkEvrHQPuzrBLhokzKzz9BirDgMT/ViAIhsT0Xr7x6tDSF3Ok0aGl
         s9W7VdNe+R3c9rd7Qc+oVhCLTIVhxYoxs23lVCqYYoHDUWo6ImR2M/C0zjHtPeuWyRzT
         SRE3+tS3nT9S8UT9dk3dzY57tPLTmNl0+MBj4twnbZUpv5PECjZ101ohfdud+EpPc9AR
         aKPQ==
X-Gm-Message-State: AOAM533n7btFluaTcPXgTvEmpMl1/w2ULLoRHYs4OTCdTypajSF2yIt0
        PKlBLNZqGSWR/Hmyz5ruRbQLZQ==
X-Google-Smtp-Source: ABdhPJy7jqKjGTMV11AWKe86R0PMG5Y3KegZsSQhQrGl3tDdv4tkTqy3D3Htk/lV8nIjmGy3jnVubg==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr8235433wmf.73.1636474526226;
        Tue, 09 Nov 2021 08:15:26 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j134sm3304249wmj.3.2021.11.09.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 08:15:25 -0800 (PST)
Date:   Tue, 9 Nov 2021 17:15:24 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ido Schimmel <idosch@idosch.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, edwin.peer@broadcom.com
Subject: Re: [PATCH net-next] devlink: Require devlink lock during device
 reload
Message-ID: <YYqenGW4ftZH5Ufi@nanopsycho>
References: <YYgSzEHppKY3oYTb@unreal>
 <20211108080918.2214996c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YYlfI4UgpEsMt5QI@unreal>
 <20211108101646.0a4e5ca4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YYlrZZTdJKhha0FF@unreal>
 <20211108104608.378c106e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YYmBbJ5++iO4MOo7@unreal>
 <20211108153126.1f3a8fe8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211109144358.GA1824154@nvidia.com>
 <20211109070702.17364ec7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109070702.17364ec7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Nov 09, 2021 at 04:07:02PM CET, kuba@kernel.org wrote:
>On Tue, 9 Nov 2021 10:43:58 -0400 Jason Gunthorpe wrote:
>> This becomes all entangled in the aux device stuff we did before.
>
>So entangled in fact that neither of you is willing to elucidate 
>the exact need ;)
>
>> devlink reload is defined, for reasons unrelated to netns, to do a
>> complete restart of the aux devices below the devlink. This happens
>> necessarily during actual reconfiguration operations, for instance.
>> 
>> So we have a situation, which seems like bad design, where reload is
>> also triggered by net namespace change that has nothing to do with
>> reconfiguring.
>
>Agreed, it is somewhat uncomfortable that the same callback achieves
>two things. As clear as the need for reload-for-reset is (reconfig,
>recovery etc.) I'm not as clear on reload for netns.
>
>The main use case for reload for netns is placing a VF in a namespace,
>for a container to use. Is that right? I've not seen use cases
>requiring the PF to be moved, are there any?
>
>devlink now lives in a networking namespace yet it spans such
>namespaces (thru global notifiers). I think we need to define what it
>means for devlink to live in a namespace. Is it just about the
>configuration / notification channel? Or do we expect proper isolation?
>
>Jiri?

Well honestly the primary motivation was to be able to run smoothly with
syzkaller for which the "configuration / notification channel" is
enough.

By "proper isolation" you mean what exactly?


>
>> In this case the per-net-ns becomes a BKL that gets
>> held across way too much stuff as it recuses down the reload path,
>> through aux devices, into the driver core and beyond.
>> 
>> When I looked at trying to fix this from the RDMA side I could not
>> find any remedy that didn't involve some kind of change in netdev
>> land. The drivers must be able to register/unregister notifiers in
>> their struct device_driver probe/remove functions.
>> 
>> I once sketched out fixing this by removing the need to hold the
>> per_net_rwsem just for list iteration, which in turn avoids holding it
>> over the devlink reload paths. It seemed like a reasonable step toward
>> finer grained locking.
>
>Seems to me the locking is just a symptom.
