Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FAA4224B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhJELNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234295AbhJELNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633432300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeArBAcS9Q84SLX+oAxukLYME3k/d29Rm/s+++jGKPE=;
        b=aP4eAenUkIHLEZ2Z6l0U25AbwG87RG7D+IV7FuWxnksjI9mQgTDaF9NMNKrujf8bzFhiw0
        XPWmaY12ypT9ByQFxpqcLDqy/9QBKUpVxz10WKNK8QiddY+RrlcHXa8jZKRyy8PeYNMzpu
        Mm5Bg+PeH08yJicSA+UsoVX7RNgBYk8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-L5BF3q9sNVClJC7D7LiDrw-1; Tue, 05 Oct 2021 07:11:38 -0400
X-MC-Unique: L5BF3q9sNVClJC7D7LiDrw-1
Received: by mail-ed1-f70.google.com with SMTP id d23-20020a50f697000000b003daf215e1efso5942353edn.23
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eeArBAcS9Q84SLX+oAxukLYME3k/d29Rm/s+++jGKPE=;
        b=jbJ3emPPcmwQMAfu1r6IFtnauJ6AA0yojTUJ/fJMBbbGNgaCPG+zd7JexIiFRfcUFr
         eMQhLMmM8TH7odjzpv4pN8/BS49hcFJfKiOwQeZaX/4uQD0G++UndjU/iUGodCPruONv
         BAdn0KjSfrP1TVNYBaSO+xdaJYEp7xBx5JZxrmEpc9RH5SBYYutl87U1l8122RTFyWIe
         e6TmRZHokOdzHedF91Yy5ghsnrG4AuXjOW10TG0iz8xCZDBW+4R9T65fiYBtWzcsgN2z
         mCtbwCn8lzniZTs+4YZlLPHvcCj6oWJFQZvByM/HWebbx1JTP+YrjshTnh7VcH/1qaMn
         DPnA==
X-Gm-Message-State: AOAM5337y/14YeCJ5PpJ2ExeEqzl8wba6HuckBpt0xKWVI28On2vD5aH
        +FvxZfyg3GGVo8xrtnkBN1C/pqC5/X6UqLgnea6XLK80ejYGKzXvpJdfIgd9sPlLiaofvtD+YXt
        MjPRfodvHlbqqhNDh2sPJNzXz
X-Received: by 2002:a17:906:81da:: with SMTP id e26mr23837035ejx.296.1633432297532;
        Tue, 05 Oct 2021 04:11:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcsiNXEPQdBdUK3S2sCQgXB8aTeyms7C9ktkEXECdOiZs9AxXkmtcIiymlmiwW6qydZSPVfw==
X-Received: by 2002:a17:906:81da:: with SMTP id e26mr23837003ejx.296.1633432297372;
        Tue, 05 Oct 2021 04:11:37 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id q6sm7451568ejm.106.2021.10.05.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 04:11:36 -0700 (PDT)
Date:   Tue, 5 Oct 2021 07:11:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005071128-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <20211005092539.145c9cc4.pasic@linux.ibm.com>
 <20211005035014-mutt-send-email-mst@kernel.org>
 <20211005124634.2a774796.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005124634.2a774796.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:46:34PM +0200, Halil Pasic wrote:
> On Tue, 5 Oct 2021 03:53:17 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > Wouldn't a call from transport code into virtio core
> > > be more handy? What I have in mind is stuff like vhost-user and vdpa. My
> > > understanding is, that for vhost setups where the config is outside qemu,
> > > we probably need a new  command that tells the vhost backend what
> > > endiannes to use for config. I don't think we can use
> > > VHOST_USER_SET_VRING_ENDIAN because  that one is on a virtqueue basis
> > > according to the doc. So for vhost-user and similar we would fire that
> > > command and probably also set the filed, while for devices for which
> > > control plane is handled by QEMU we would just set the field.
> > > 
> > > Does that sound about right?  
> > 
> > I'm fine either way, but when would you invoke this?
> > With my idea backends can check the field when get_config
> > is invoked.
> > 
> > As for using this in VHOST, can we maybe re-use SET_FEATURES?
> > 
> > Kind of hacky but nice in that it will actually make existing backends
> > work...
> 
> Basically the equivalent of this patch, just on the vhost interface,
> right? Could work I have to look into it :)

yep

