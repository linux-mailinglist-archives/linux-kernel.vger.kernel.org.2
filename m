Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9332311CEF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBFLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:43:34 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42006 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:43:30 -0500
Received: by mail-wr1-f52.google.com with SMTP id r7so1155288wrq.9;
        Sat, 06 Feb 2021 03:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z5+il/kFvaOKLe+vkHQ3jUQ2W//xLcXbRoumcD7gta0=;
        b=DleaozABJOncx6a9QTuZX6r3lHnAfU8KbiFkT+WTycXwXlZ9c3f1P4IPaj58fw8zCY
         edN4y3AhwEQLYJn6hrTkZqUkFQ147fiLQ6g58YOKM6h90BwPK2daz5g2bHq5L23Dmy+x
         moIOGCt0drv1197FSjG7MIYUcA+ymSy2Wl2/lsfw3j84U1nOziXm5Rk5IKHCJoxsITA7
         BlvW6mTF2MqRNRMba6z5mQOciygXmcSIAj2RZABET2WYBSbbPqoxfoccB7x7oQ3GIHwE
         T773pwSOI+157aiWT4sSSaG+/TlSwRTFGoCUVPbBlSqedfHoZfr1aGHd0ARKSd7Eidf9
         tArw==
X-Gm-Message-State: AOAM530ykOsqBcz1TMEBhwM/ywNpI31Cnf2JzzY9HEmrwkpkKpI1ycGS
        RHJjEsuvi9nmTg65YCyLVOkJHUKM/GM=
X-Google-Smtp-Source: ABdhPJwmuRNDbRfe7XUqGtzhJtpUMljOeJ+rcHo/cs7ssJn/GZRZrN22zmidYNSXEEBIIyQjO2Ksrw==
X-Received: by 2002:adf:f750:: with SMTP id z16mr10028432wrp.243.1612611766217;
        Sat, 06 Feb 2021 03:42:46 -0800 (PST)
Received: from kozik-lap (194-95-143-94.dyn.cable.fcom.ch. [94.143.95.194])
        by smtp.googlemail.com with ESMTPSA id c20sm10936238wmb.38.2021.02.06.03.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 03:42:45 -0800 (PST)
Date:   Sat, 6 Feb 2021 12:42:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] ARM: dts: ls1021a: change to use SPDX identifiers
Message-ID: <20210206114243.txc2jujr5acos2gf@kozik-lap>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
 <20210205234734.3397-5-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210205234734.3397-5-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:47:23PM -0600, Li Yang wrote:
> Replace the license text with SPDX identifiers.  In the mean while
> updated copyright years for previous changes.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a-qds.dts | 46 ++-----------------------------
>  arch/arm/boot/dts/ls1021a-twr.dts | 46 ++-----------------------------
>  arch/arm/boot/dts/ls1021a.dtsi    | 45 ++----------------------------
>  3 files changed, 6 insertions(+), 131 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> index 74a67604876c..71bab93bc4cc 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -1,49 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright 2013-2014 Freescale Semiconductor, Inc.
> - * Copyright 2018 NXP

Please split the copyright update. Adding a SPDX is not big enough to
justify adding new copyrights. On the other hand, if NXP contributed
over time and you want to reflect it in the copyrights, it's a different
path.

> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of
> - *     the License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - *     You should have received a copy of the GNU General Public
> - *     License along with this file; if not, write to the Free
> - *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> - *     MA 02110-1301 USA
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> + * Copyright 2018-2021 NXP
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
> index 5edf001f6138..01bf316bcc99 100644
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -1,49 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright 2013-2014 Freescale Semiconductor, Inc.
> - * Copyright 2018 NXP
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of
> - *     the License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - *     You should have received a copy of the GNU General Public
> - *     License along with this file; if not, write to the Free
> - *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> - *     MA 02110-1301 USA
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> + * Copyright 2018-2020 NXP
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 007dd2bd0595..4bf6320c85d9 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -1,48 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright 2013-2014 Freescale Semiconductor, Inc.
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of
> - *     the License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - *     You should have received a copy of the GNU General Public
> - *     License along with this file; if not, write to the Free
> - *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> - *     MA 02110-1301 USA
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> + * Copyright 2015-2021 NXP

Srsly, you even add here entirely new copyrights hidden under a SPDX
change.

No, it's not the way to do it.

Best regards,
Krzysztof
