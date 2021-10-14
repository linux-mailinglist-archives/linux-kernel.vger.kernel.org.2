Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DD542DEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhJNQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231447AbhJNQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634227572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHg4HlgMgzRHtg++Fc+hLUEoje2Yk5cV4ugp4TbbFmI=;
        b=idHJGwn9mz0OYtuB6Y4wdL8qm4ooKGGhblmr2RPUKiNlaUIIBzzuQYwkz+v7ObBbw079Hx
        evF7cPmzuGAvUMv5ffgFu0OsQObTLANqhGGLiFqFNACJfziUK2sNf/W5xA5jcxs5dwzpaQ
        gU53RQs9NbqNjNHIWK/pYkf7U8QTnUU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-OWCijL8ANTKTaw16fuxBcg-1; Thu, 14 Oct 2021 12:06:09 -0400
X-MC-Unique: OWCijL8ANTKTaw16fuxBcg-1
Received: by mail-wr1-f72.google.com with SMTP id 10-20020a5d47aa000000b001610cbda93dso4882769wrb.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fHg4HlgMgzRHtg++Fc+hLUEoje2Yk5cV4ugp4TbbFmI=;
        b=pH41KstDmqoSO3yUoTsFB16GEmpHu2n4qt4GfUmSVjuoCBYszRy/To7veUu4egqrIv
         CokDv92EtFOYyoa/BcI8WNzxoDgSxQMD1tjNV+pNQFg5s5/AGN8WyHjEuLOh4A0pQJ3W
         CC+xgn/3nPs/fHOyrd+/yRputmR0YuKDPojJLJCETdTGDp6dEEK8MLidntJAP/JUxbOE
         /2R9vKxBZAz9iu7oC1ScsIJ7ecdgYRdoWYAvZxuoCdsNipyOOmbfrjrTMLPyGp1Y7vs4
         G/yWzP2gCT3vJb9g6ie7NJnrP3MEmGTS83JfprlzniNfa9sdeD4ueel99JkON7jY1WDs
         1RSw==
X-Gm-Message-State: AOAM531Gi4Irn/GBis6LV3LxXe09qREzfVyZ7bqCLAyVaRZkrrsyeG5u
        FAL4fbyxx0Edu4v2VMPx94VW8AisNTfo42GJovz/A6o3hi8Fm0hS0nY0sGAv7jZ36fKMsr+eVrj
        uEMRdsr05HaDrCSaInXN7X+S7
X-Received: by 2002:adf:a496:: with SMTP id g22mr7939861wrb.13.1634227568601;
        Thu, 14 Oct 2021 09:06:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySk/fQpRl6DwfsCWMhA+enhUFCudbCW1I9/5xd2iEuK3qhXE8JwJDnhT2+zrcCB/i6fERdkQ==
X-Received: by 2002:adf:a496:: with SMTP id g22mr7939831wrb.13.1634227568417;
        Thu, 14 Oct 2021 09:06:08 -0700 (PDT)
Received: from redhat.com ([2.55.1.103])
        by smtp.gmail.com with ESMTPSA id r9sm2608216wrn.95.2021.10.14.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:06:07 -0700 (PDT)
Date:   Thu, 14 Oct 2021 12:06:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com
Subject: Re: data dependency naming inconsistency
Message-ID: <20211014120540-mutt-send-email-mst@kernel.org>
References: <20211011064233-mutt-send-email-mst@kernel.org>
 <6c362de5-1d79-512c-37d0-81aaf5d335d1@qa2.so-net.ne.jp>
 <20211014013156-mutt-send-email-mst@kernel.org>
 <d253958f-b3d7-67c1-4cf6-38f184adabd6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d253958f-b3d7-67c1-4cf6-38f184adabd6@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But I'm more inclined to get rid of remaining contents related to the
> "data dependency barrier".
> 
>         Thanks, Akira

That's an option, too.

-- 
MST

