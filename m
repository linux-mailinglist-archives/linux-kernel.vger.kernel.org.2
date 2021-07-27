Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF51A3D6CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 05:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhG0C4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 22:56:09 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:42904 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234990AbhG0C4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:56:08 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 95DA41835109D;
        Tue, 27 Jul 2021 03:36:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 8CDEC2448B5;
        Tue, 27 Jul 2021 03:36:31 +0000 (UTC)
Message-ID: <45ccb9e8c610678e72f461b1e9d61de0a4c9bc79.camel@perches.com>
Subject: Re: [PATCH v2] platform/x86/intel: Move Intel PMT drivers to new
 subfolder
From:   Joe Perches <joe@perches.com>
To:     "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        mgross@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Mon, 26 Jul 2021 20:36:30 -0700
In-Reply-To: <20210727022550.3083745-1-david.e.box@linux.intel.com>
References: <20210727022550.3083745-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8CDEC2448B5
X-Spam-Status: No, score=-0.16
X-Stat-Signature: ctnwfp3onemo6gessdmzijbbuqdtizuu
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Btk9cYTe4JtrpZlbIX6LKl0DX3OWuH7E=
X-HE-Tag: 1627356991-794102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-26 at 19:25 -0700, David E. Box wrote:
> Move all Intel Platform Monitoring Technology drivers to
> drivers/platform/x86/intel/pmt.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -9494,7 +9494,7 @@ INTEL PMT DRIVER
>  M:	"David E. Box" <david.e.box@linux.intel.com>
>  S:	Maintained
>  F:	drivers/mfd/intel_pmt.c
> -F:	drivers/platform/x86/intel_pmt_*
> +F:	drivers/platform/x86/intel/pmt/*

Unless you are suggesting you are not maintainer of any files
in any subdirectories below this directory, you should not use
a *

F:	drivers/platform/x86/intel/pmt/

> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
[]
> @@ -7,3 +7,4 @@
>  obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
>  obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
>  obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
> +obj-y					+= pmt/

This seems odd.  Perhaps:

obj-$(CONFIG_PMT_CLASS)				+= pmt/

?


