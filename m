Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27963D093B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhGUGMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhGUGM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:12:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED102C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+skYpVFx7D26gZP3u4sFvQmDQJ66kJNmYAf8MY+5yFI=; b=TaTMVqhlAYzzaMNEl9YC7dzmxn
        1CXjRkMdMpvsxrcDsiWSN+C7YsUcSGcnzfszUyULbfcS4ooEOY9tYgSTcSDi8G0+oWilUGS6sOcPf
        nLp4xhpCmloqX13mk1sMDi5gtqkhduaQ+k6J7vhS99Z+ty7iwqeV+TAF87tjbFtL39SRWdu7qwI4I
        Vgt4l+1YRSeRmJMUI+A2kV6QVzaS/HZMFW/RSB+q0xG3mDki08KQH4msQrqT0KjcXd87usNNUZ9Ch
        ufmPwWhMwnf8G0/afdBOJAMzOP2q4EjptdlCBBhK1vzXw/mz7U7siUAfM4yKdONCURjyTTfLtOm62
        Wn3DySvA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m665B-008tgP-6t; Wed, 21 Jul 2021 06:51:56 +0000
Date:   Wed, 21 Jul 2021 07:51:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian K??nig <christian.koenig@amd.com>
Cc:     Anson Jacob <Anson.Jacob@amd.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
        Rodrigo.Siqueira@amd.com, roman.li@amd.com,
        Christoph Hellwig <hch@infradead.org>,
        Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
        bindu.r@amd.com
Subject: Re: [RFC v2 2/2] drm/amd/display: Use PPC FPU functions
Message-ID: <YPfECUtD0SRCjrSm@infradead.org>
References: <20210721044801.840501-1-Anson.Jacob@amd.com>
 <20210721044801.840501-3-Anson.Jacob@amd.com>
 <9094cea1-602e-6e71-4ff7-c06fd04af6c5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9094cea1-602e-6e71-4ff7-c06fd04af6c5@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 08:29:43AM +0200, Christian K??nig wrote:
> Looks good in general, but question is what about other architectures like
> ARM?

DRM_AMD_DC_DCN currently requires X86 || PPC64.

Maybe a good think would be to add a new KERNEL_FPU_API Kconfig symbol,
selected by x86 and powerpc (I think ppc32 should be fine too now) so
that we get these arch dependencies out of the driver.
