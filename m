Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7531C4073DC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhIJX2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234790AbhIJX2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:28:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07A4E61211;
        Fri, 10 Sep 2021 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631316444;
        bh=MTpyGMzRwzcZckX1Knm3eAP7QqVukVmqh2sPwyO9Yu0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DyyDq8G4s5uAzUcahf9t9rQB8ahLVLLBpkqerShVx5NmalJXs5fAu1lbV6IZ+WhzX
         XAcn58BFCMUD2sKtlYkoaWIFkckUj1/UG44RorEAw795xzQkBz7zwR6wSEi05NuOOs
         N16VJ43Qr8cCd19Vqqc3v2WDMYtOFsUcEZ1Ea2rRi8kfMBUKc/QPPhBlKfvfLiWffH
         2FtDXArYULt2YKZB6w9frMgxvgQzdr+CxoTPUThOoEMb5/xCBMOVbPt/RYXZb8oCc4
         qhMZQ+fhiFMz1tqxpuv4aIaj00F7cRdYcTEnPOVI0O+73zBaN39eFLqp6qoZuep4Yw
         XKCUYsZ6HSUEA==
Date:   Fri, 10 Sep 2021 16:27:23 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 09/12] swiotlb-xen: drop DEFAULT_NSLABS
In-Reply-To: <15259326-209a-1d11-338c-5018dc38abe8@suse.com>
Message-ID: <alpine.DEB.2.21.2109101627170.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <15259326-209a-1d11-338c-5018dc38abe8@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> It was introduced by 4035b43da6da ("xen-swiotlb: remove xen_set_nslabs")
> and then not removed by 2d29960af0be ("swiotlb: dynamically allocate
> io_tlb_default_mem").
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -152,8 +152,6 @@ static const char *xen_swiotlb_error(enu
>  	return "";
>  }
>  
> -#define DEFAULT_NSLABS		ALIGN(SZ_64M >> IO_TLB_SHIFT, IO_TLB_SEGSIZE)
> -
>  int xen_swiotlb_init(void)
>  {
>  	enum xen_swiotlb_err m_ret = XEN_SWIOTLB_UNKNOWN;
> 
