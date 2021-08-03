Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF23DF4EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbhHCSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237949AbhHCSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628016316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23GDkNLhLe5EW0NBURzRb+WIAuJSlfKe4etutEbvPx8=;
        b=RN6IlZE+amoFxVRuWTD3AIVLjvFumFKF0eX7FxuIeAf821xZWrT/SAIe31GOGNVZpGs8kp
        Udxss4sf7EElmT6l17l0yymFYNGTg/yOvWv50CLBpyl74FcLkNCQNHq2NAtcioWU6/pWJR
        hceLFbi1GYBXYaGb/gfC7VfCHKQRLCY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-1TSvBaqoPjyxzQrmTtH2UA-1; Tue, 03 Aug 2021 14:45:12 -0400
X-MC-Unique: 1TSvBaqoPjyxzQrmTtH2UA-1
Received: by mail-oo1-f71.google.com with SMTP id r10-20020a4ae50a0000b02902621047077eso9394762oot.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 11:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23GDkNLhLe5EW0NBURzRb+WIAuJSlfKe4etutEbvPx8=;
        b=lNbbtsoouYMTNCjc0iWlYEPvs8a6Ec3ouiYpkgLN/vSWCeA1U0DtZ0N0Ferj63Rnp3
         pLzLMhpKzu2ucYQH/oZ9bRtMiAjEFIpvWqJYUR8aZub+RZG+YPGHppXwNAOV660hjmb7
         tpTMfWOzWPxBKgxVf3lnAvNRK6Tio6gpjjn/XWbkUEyTQxQxj0k9O3xj+KY8FGaX8DF0
         hSNfJddOKJrOawHN4M7m/M3K/LoEF+pn5RO7rFkcIY3aerT7Thi9APg46xDl3q6jyGXs
         eMFG+VBjEaSBLoluu9UIB85W7FakAz+dlOpDSvIXJKrS1vD4zxIPtS+lKLZXYyNfbkaT
         Y5xA==
X-Gm-Message-State: AOAM533xDwiNn8GAxa1GbSBEDk/riJHEeCj5SXM5y5p+S5wcEYQRjiRR
        NyEdGwd+u7ntn+AOPPqo7FU5gcYer31nGKUMScLT1K34LnlJz/dCZFDasw5XCpJSMbjGn7UlhRQ
        +JOj+rUDKZ5/o/QTwnefDGgzM
X-Received: by 2002:a05:6808:140e:: with SMTP id w14mr15296595oiv.32.1628016312012;
        Tue, 03 Aug 2021 11:45:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjwfPbRtv9ckeJhTA4ncmD0idGMo982VS6iLv1VNS5vntu3eB8DqEimcc2uqnGAXEP7yXfwg==
X-Received: by 2002:a05:6808:140e:: with SMTP id w14mr15296590oiv.32.1628016311893;
        Tue, 03 Aug 2021 11:45:11 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id p4sm2378831ooa.35.2021.08.03.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:45:11 -0700 (PDT)
Date:   Tue, 3 Aug 2021 12:45:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: two small mdev fixups
Message-ID: <20210803124510.618baf20.alex.williamson@redhat.com>
In-Reply-To: <20210726143524.155779-1-hch@lst.de>
References: <20210726143524.155779-1-hch@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 16:35:22 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> two small mdev fixes - one to fix mdev for built-in drivers, and the other
> one to remove a pointless warning.

Applied to vfio next branch for v5.15 with Connie and Jason's R-b.
Thanks,

Alex

