Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6384D41D14C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347745AbhI3CKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:10:41 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:46392 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347626AbhI3CKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:10:37 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7938418059B50;
        Thu, 30 Sep 2021 02:08:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 7F78F2351F3;
        Thu, 30 Sep 2021 02:08:53 +0000 (UTC)
Message-ID: <a61f6bc2dc18397de92e4b7cdd9b37e2dff7e114.camel@perches.com>
Subject: Re: [PATCH 2/4] amdgpu_ucode: reduce number of pr_debug calls
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Sep 2021 19:08:51 -0700
In-Reply-To: <20210930014427.14239-3-jim.cromie@gmail.com>
References: <20210930014427.14239-1-jim.cromie@gmail.com>
         <20210930014427.14239-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7F78F2351F3
X-Spam-Status: No, score=0.10
X-Stat-Signature: anmt6jx4t6f7u5gh4einmjsx1txe8h6k
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18kGVBu/5EFA7vPk09h4PPRUG51zMWAUwg=
X-HE-Tag: 1632967733-854858
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-29 at 19:44 -0600, Jim Cromie wrote:
> There are blocks of DRM_DEBUG calls, consolidate their args into
> single calls.  With dynamic-debug in use, each callsite consumes 56
> bytes of callsite data, and this patch removes about 65 calls, so
> it saves ~3.5kb.
> 
> no functional changes.

No functional change, but an output logging content change.

> RFC: this creates multi-line log messages, does that break any syslog
> conventions ?

It does change the output as each individual DRM_DEBUG is a call to
__drm_dbg which is effectively:

	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
	       __builtin_return_address(0), &vaf);


> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
[]
> @@ -30,17 +30,26 @@
>  
> 
>  static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
>  {
> -	DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
> -	DRM_DEBUG("header_size_bytes: %u\n", le32_to_cpu(hdr->header_size_bytes));
[]
> +	DRM_DEBUG("size_bytes: %u\n"
> +		  "header_size_bytes: %u\n"

etc...


