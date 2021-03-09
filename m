Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43E3332F16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCITfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:35:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhCITe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615318499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Efq/XdZADcIcPCwsZh2URVLR5lQJ44Ni5hT8xLHIW0=;
        b=K72x2s2HyAznseg8fx2KVVF345KOvCoAXk6ySPfsj/aKePtNWC1DiAHpa5QxjO92ZDJF33
        CW5Asapx/8EVk2DEwDmBBuuWxR54E8MyPu2sZIMBSAOzvZbfDiU8m38ysPhebFM2WiahDD
        N/FQyOOEljo3v+R9THFxrFEs3NiAeao=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-eGQPsf0DP5SjU20jPkFpyQ-1; Tue, 09 Mar 2021 14:34:57 -0500
X-MC-Unique: eGQPsf0DP5SjU20jPkFpyQ-1
Received: by mail-pl1-f199.google.com with SMTP id q11so5903182plx.22
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Efq/XdZADcIcPCwsZh2URVLR5lQJ44Ni5hT8xLHIW0=;
        b=tzRY/Bmz80bOlzYOIcbsietaXkg7Wo4zzFM2AQBfb+QJgr8js7WAUVgQK4Bw6vWwY4
         iXEY52PBd03Wizf8IW9GBVNr6mNpZ+htm6pEBmmNhAquGbSziBWf0/dr+50aCzjQy4qL
         0HrnP8TldQCoeUroCjGChIV+prIN1DUyBNzz3p/fZsMBj/0cEFySf5lVK5+rMBR7IGT7
         cxknx2jaHq7kDEFCmccZS5dvBxAZQPlOgEq1ulnTssjTMXRzDgEMmLgF7WHJseXvNRmM
         MxhJzt6B42ICkfJx7jF5t9DP2h6o2ZNO96lfqV8JBtArKp3HwXjdQ3gEf827McG6A5ie
         N9vQ==
X-Gm-Message-State: AOAM53158708fTw3/8F2MpWdv+P+LpH5+ej+IRFwyzJaJth9wU9jPXjy
        v0RfwgsWJpwR0/TjFXY470yrnxMN1QJKbXHmibEt19obiD0hSO7x7UBS5enT62Rgt0HCaXqo2O7
        fmR6QAi5n7BpWsUZ9/eOnkEmF
X-Received: by 2002:aa7:9910:0:b029:1f1:b41b:f95c with SMTP id z16-20020aa799100000b02901f1b41bf95cmr16633073pff.5.1615318496366;
        Tue, 09 Mar 2021 11:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEm2SCLdiAFQWg7SaJuVodSLt/bg3Ucx4zEwtP8tgO/rpA7knG+uMEuOT6zr7D47BEOpBgZw==
X-Received: by 2002:aa7:9910:0:b029:1f1:b41b:f95c with SMTP id z16-20020aa799100000b02901f1b41bf95cmr16633059pff.5.1615318496200;
        Tue, 09 Mar 2021 11:34:56 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gw20sm3591571pjb.3.2021.03.09.11.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 11:34:55 -0800 (PST)
Date:   Wed, 10 Mar 2021 03:34:41 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] fs: add an argument-less alloc_anon_inode
Message-ID: <20210309193441.GB3958006@xiangao.remote.csb>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:53:41PM +0100, Christoph Hellwig wrote:
> Add a new alloc_anon_inode helper that allocates an inode on
> the anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

