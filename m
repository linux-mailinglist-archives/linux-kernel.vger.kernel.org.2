Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6983041619A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbhIWPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241807AbhIWPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632409221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KAWkRRiP+ToKhHsVmpncsGA+uG5zL1/UXnCV1dJpPg0=;
        b=dIgqxDPn6IDFCzO1SuK7v/H2txrHfwzXSjGY+tISbn3xhUqStyO3Mk4C44jvpssjH2pn+j
        h23zcOWchwtDLZnNeo/xay2e63LqHDMmiObzLkWA+fRFayVr4H49a+aaK1STdAuyzoNuVK
        Y0kE/hLaC5iJsdHgTWiyWExiXVlq1zE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-YMlr34KuMtGDNMdZjlcpHg-1; Thu, 23 Sep 2021 11:00:20 -0400
X-MC-Unique: YMlr34KuMtGDNMdZjlcpHg-1
Received: by mail-qt1-f198.google.com with SMTP id 62-20020aed2044000000b002a6aa209efaso16796353qta.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KAWkRRiP+ToKhHsVmpncsGA+uG5zL1/UXnCV1dJpPg0=;
        b=NY67pKlux+8MvpjqdAU9Q6Lq5Lpou6rCTFvL0pfChVgW3XTRfwQtHgpL1LFzRXkg/R
         /8UjtUK69KQJaOu1N/unH8nNxtiTCvgbqVyu7ppWLmCu4vIxCr+Q0jk8sZW3ug0qn4sY
         tNnjDMGjqzyj9RQPFznyf6Rcf6uCyNjEr/PDsjpw57vqix03Srw4p8NJAh3MTJeCU9IQ
         guixZ4PvXtkmxMehHYYOYPBISsQpgMUEtZTakMUQGaglmn1Cv7pEgyvGPTCttYCSfthV
         mTCP/QVrACE02BxU828lEKP6/nS6CgaMZVu4gPRamJ/AjNfb3ncy1VGBGWlDddGf8R61
         vY1w==
X-Gm-Message-State: AOAM532kQZH/6XeQdgwLwsoniNH/Q0aXIV3ytDaCnqPuY+z54qGqWcaB
        r09PS2NmacszH6x7d7qqNaD/+noFOPiXqbJx1KY03S0lmVzbyR531D8ooUvi59UONIMaYiUh7MU
        r8/mXjm7U5zJPIe2R82AKU0bg
X-Received: by 2002:a05:620a:9c9:: with SMTP id y9mr5187045qky.207.1632409219589;
        Thu, 23 Sep 2021 08:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvF3oUBDTyvXXjo1UJaYDIMU/wevu6DSYRKaGO/Oh7HtqhBOY7spzcnGEiBKrNIRshX75npw==
X-Received: by 2002:a05:620a:9c9:: with SMTP id y9mr5187008qky.207.1632409219296;
        Thu, 23 Sep 2021 08:00:19 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id u4sm3574935qtq.31.2021.09.23.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:00:18 -0700 (PDT)
Date:   Thu, 23 Sep 2021 11:00:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com, chris.riches@nutanix.com
Subject: Re: [PATCH v3 1/1] Documentation: update pagemap with shmem
 exceptions
Message-ID: <YUyWganKYoWOF1ns@t490s>
References: <20210923064618.157046-1-tiberiu.georgescu@nutanix.com>
 <20210923064618.157046-2-tiberiu.georgescu@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923064618.157046-2-tiberiu.georgescu@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:46:18AM +0000, Tiberiu A Georgescu wrote:
> Mentioning the current missing information in the pagemap and alternatives
> on how to retrieve it, in case someone stumbles upon unexpected behaviour.
> 
> Signed-off-by: Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
> Reviewed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
> Reviewed-by: Florian Schmidt <florian.schmidt@nutanix.com>
> Reviewed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
> Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

