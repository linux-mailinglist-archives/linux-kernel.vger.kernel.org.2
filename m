Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA52537BECF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhELNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:51:02 -0400
Received: from foss.arm.com ([217.140.110.172]:39528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhELNvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:51:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BDE96D;
        Wed, 12 May 2021 06:49:52 -0700 (PDT)
Received: from bogus (unknown [10.57.35.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C1353F718;
        Wed, 12 May 2021 06:49:50 -0700 (PDT)
Date:   Wed, 12 May 2021 14:49:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 30/40] docs: ABI: Use ASCII subset instead of UTF-8
 alternate symbols
Message-ID: <20210512134940.j7kxcb7cbv56ic6y@bogus>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <5109b6739272e1faa637ba2acb33b3129131d4aa.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5109b6739272e1faa637ba2acb33b3129131d4aa.1620823573.git.mchehab+huawei@kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 02:50:34PM +0200, Mauro Carvalho Chehab wrote:
> The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
> and some automatic rules which exists on certain text editors like
> LibreOffice turned ASCII characters into some UTF-8 alternatives that
> are better displayed on html and PDF.
> 
> While it is OK to use UTF-8 characters in Linux, it is better to
> use the ASCII subset instead of using an UTF-8 equivalent character
> as it makes life easier for tools like grep, and are easier to edit
> with the some commonly used text/source code editors.
> 
> Also, Sphinx already do such conversion automatically outside literal blocks:
>    https://docutils.sourceforge.io/docs/user/smartquotes.html
> 
> So, replace the occurences of the following UTF-8 characters:
> 
> 	- U+2018 ('‘'): LEFT SINGLE QUOTATION MARK
> 	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[...]

I think I copy pasted the text from elsewhere, there is no way I managed
to type that 😄. Anyways, for the change in sysfs-devices-soc:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
> index ea999e292f11..7f90c6a44610 100644
> --- a/Documentation/ABI/testing/sysfs-devices-soc
> +++ b/Documentation/ABI/testing/sysfs-devices-soc
> @@ -27,11 +27,11 @@ Description:
>  		(e.g. DB8500).
>  
>  		On many of ARM based silicon with SMCCC v1.2+ compliant firmware
> -		this will contain the JEDEC JEP106 manufacturer’s identification
> +		this will contain the JEDEC JEP106 manufacturer's identification
>  		code. The format is "jep106:XXYY" where XX is identity code and
>  		YY is continuation code.
>  
> -		This manufacturer’s identification code is defined by one
> +		This manufacturer's identification code is defined by one
>  		or more eight (8) bit fields, each consisting of seven (7)
>  		data bits plus one (1) odd parity bit. It is a single field,
>  		limiting the possible number of vendors to 126. To expand
> -- 
> 2.30.2
> 

-- 
Regards,
Sudeep
