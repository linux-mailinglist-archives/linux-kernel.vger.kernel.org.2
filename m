Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E293429960
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 00:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhJKWVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 18:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235477AbhJKWVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 18:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633990763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aeXcIsOyNcWtQCi9/bt2+iuYkngLdU5FSyhdmH84bAc=;
        b=ZwewXx7O2Z9uvl4BA/C7r9KNDIFCSpgMsY0UPJPa9t/+dyXdnmwXyMMRlJekfQYakkFSO3
        pj/chPxBq1BlUGz3f/yoCJiJ7IuHFNBvCkiX4Jxb5vHeu7lhZJ8N/8I5d8mPCKkoSOvPoU
        aZPMAkT7TlJoMt+E/1nGeEqP2EuZ5zc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-eFi5krm9PryxzWB021CD9Q-1; Mon, 11 Oct 2021 18:19:22 -0400
X-MC-Unique: eFi5krm9PryxzWB021CD9Q-1
Received: by mail-ot1-f72.google.com with SMTP id r3-20020a056830236300b0054d43b72ba5so11288720oth.17
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 15:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeXcIsOyNcWtQCi9/bt2+iuYkngLdU5FSyhdmH84bAc=;
        b=P2Hka9uU+1wIcJylhd3PiDVQ4/uISycchiJoDn9LlaNp0WORYwaXSt0cvKMkJHufJx
         qF2nLPADqIptPnWvvBAt+tCnhINIdGZ3AYaubonXoINP1P0c6bcn1Fd5dhAvLkEDuPw5
         ixD7ap3YK454co+cImpmWzJ0JIqeZ+8XmGzZxE5GUHSG7V5I34TXOo35RT5gFeJVZ+Te
         Iw9COacyBYfnQH77W0uXxYXqIDS9spsTZDnhk3UYt+FzY1kCcW5WPH5xzooH9IDeaiZT
         2G8awXbggO1dBntMUlS5IluPny3wb4smF2QSJCkIkzCMonK5VD+rEoNzLIrKqArGyG0z
         M2SQ==
X-Gm-Message-State: AOAM533hsOLbz2oDzfUjfCMkz12DmYDVwnewe4FkgQoFnfN5uQvp/0l2
        +6BN2PhR+cT1uqQYeDdYZHd0XdNzb2IvIAIYkJzfAgPGEp+pFhGTe8pGad3Qd88PTactGINbhEV
        Fm7tWjyvhJ8irJWssF5wRVDQ8
X-Received: by 2002:aca:b10b:: with SMTP id a11mr1156557oif.177.1633990760636;
        Mon, 11 Oct 2021 15:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBgW1M4fQn8z4GIqtMKYD0bAdAahgMyBSniuW90BuiIK088EO9nAEjLcW3ZN8rRzTgzgejrg==
X-Received: by 2002:aca:b10b:: with SMTP id a11mr1156481oif.177.1633990758983;
        Mon, 11 Oct 2021 15:19:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i15sm1981679otu.67.2021.10.11.15.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 15:19:18 -0700 (PDT)
Date:   Mon, 11 Oct 2021 16:19:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Diana Craciun <diana.craciun@oss.nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kvm@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] vfio/fsl-mc: Add per device reset support
Message-ID: <20211011161916.6a3aace0.alex.williamson@redhat.com>
In-Reply-To: <e356b582-7911-6c8e-3201-dbfdbd3e3b1d@nxp.com>
References: <20210922110530.24736-1-diana.craciun@oss.nxp.com>
        <20210922110530.24736-2-diana.craciun@oss.nxp.com>
        <e356b582-7911-6c8e-3201-dbfdbd3e3b1d@nxp.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 16:55:06 +0300
Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:

> On 9/22/2021 2:05 PM, Diana Craciun wrote:
> > Currently when a fsl-mc device is reset, the entire DPRC container
> > is reset which is very inefficient because the devices within a
> > container will be reset multiple times.
> > Add support for individually resetting a device.
> > 
> > Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> > ---  
> 
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied both to vfio next branch for v5.16, with Laurentiu's R-b added
here.  Thanks,

Alex

