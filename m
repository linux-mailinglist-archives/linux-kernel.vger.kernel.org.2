Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9B30DBED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhBCNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232535AbhBCNwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612360283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DhEofLaMJjZ1tt7Cq7N3qGi1/742c/Y3DEA1AwMW1g=;
        b=APrikD6t86edAmILKfOvMfbU0RCW1hqkhtvbxUDLYXf/gZz49cCtnAGkQZ/G6IbTrK1yC8
        tY5DnmaNgoUP5vkcFC2jOKfQ19Trgj2v0xU+HxM8AVsx1UL7o48YC6DfS3L6UKjTo/ZUtt
        3JWITAG5wWJxdRFKLsNSkA8mlli+RG4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-HP9GlbT5M_6piQiyeC5QbQ-1; Wed, 03 Feb 2021 08:50:26 -0500
X-MC-Unique: HP9GlbT5M_6piQiyeC5QbQ-1
Received: by mail-qt1-f200.google.com with SMTP id w3so16987760qti.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 05:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DhEofLaMJjZ1tt7Cq7N3qGi1/742c/Y3DEA1AwMW1g=;
        b=jB5ejpv8uR0OeFDHGJH4wibDn5eTH9A5f6SJsxpikSuwDnC7XnveMmzsNLyxPFF2LE
         Lz/Hq1qpHtlyK7qR1c+3ZaS/4vj/QPl/EeG4uPfLAcmsoZ5VKtrEmIYkTvOLxt/oIuNk
         jzRVA7XWsP/Uw8/zgGlVpxXs7EeV8eRk25T/HRsO6ikIYS8mOT2RHW9RcCn80yDISz7S
         rp+hhS+dOZwYvSDafQ2TboQaq52X33OleojNhqnrpEy6OjgwvAFh00QCojivn4FZ+lAR
         utARr/uNSTLHSfvappkuzyDsTnHmuHqx1WMdZRYk3sZpD4g382TCSlgfAzpVdqrkS89X
         halA==
X-Gm-Message-State: AOAM531xh1Ihu/nc03+YlXYKbF/8OWAN/PF6XeFtLe0F3hCmIyRDXi3m
        pP3itsfx7ODfRoVTBKq71fcwsxM7RGNhcQOLTjkxRUVR1LcrD+ElQ19AQUAAAyNIqbcjfzhW6EQ
        M/TxaS/uLN4URUwc5w+s87oO+
X-Received: by 2002:ae9:ed04:: with SMTP id c4mr2457901qkg.289.1612360225727;
        Wed, 03 Feb 2021 05:50:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdpG6zb1OO0QuYugj8PvmHLYZmdPd2y0ikD+0cdb6QgqAXJKDD8pYPXUAgkWzhbsUrGx0R8A==
X-Received: by 2002:ae9:ed04:: with SMTP id c4mr2457888qkg.289.1612360225548;
        Wed, 03 Feb 2021 05:50:25 -0800 (PST)
Received: from loberhel7laptop ([2600:6c64:4e7f:cee0:ccad:a4ca:9a69:d8bc])
        by smtp.gmail.com with ESMTPSA id 75sm1349448qta.68.2021.02.03.05.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 05:50:24 -0800 (PST)
Message-ID: <de50b6b8c867ec1f88df54f92134a99b086da8ac.camel@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
From:   Laurence Oberman <loberman@redhat.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 03 Feb 2021 08:50:22 -0500
In-Reply-To: <BYAPR04MB4965222989DE60A2F198358286B49@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201164850.391332-1-djeffery@redhat.com>
         <20210202033343.GA165584@T590> <20210202204355.GA31803@redhat>
         <20210203023517.GA948998@T590>
         <BYAPR04MB4965222989DE60A2F198358286B49@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-03 at 03:15 +0000, Chaitanya Kulkarni wrote:
> On 2/2/21 18:39, Ming Lei wrote:
> > +		/* fall through */
> >  	case REQ_OP_WRITE_ZEROES:
> > -		return 0;
> 
> I don't think returning 1 for write-zeroes is right,
> did you test this patch with write-zeores enabled controller with
> the right fs that triggers this behavior ?
> 
> 
I tested the first iteration of the patch fully mounting an XFS file
system with -o discard and creating and deleting files.
That was our specific RHEL8 failure we were handling here with David's
first submission.

I can test his most recent, I have not done that yet.
Again, please follow up with exactly what you want based against
David's patch and I can test that.

Regards
Laurence 

