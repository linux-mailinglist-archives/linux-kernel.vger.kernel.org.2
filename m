Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14569311E95
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 17:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBFQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 11:08:08 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51947 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhBFQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 11:08:05 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l8Q7G-001ebd-KX; Sat, 06 Feb 2021 17:07:22 +0100
Received: from pd9f74830.dip0.t-ipconnect.de ([217.247.72.48] helo=[192.168.178.23])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l8Q7G-002tp2-8y; Sat, 06 Feb 2021 17:07:22 +0100
Subject: Re: [PATCH] ia64: Fix style guide breakage
To:     Amy Parker <enbyamy@gmail.com>, schnelle@linux.ibm.com,
        corbet@lwn.net, mchehab+huawei@kernel.org,
        tsbogend@alpha.franken.de
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210205220618.611388-1-enbyamy@gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <a3215a2b-76d3-6285-8072-160a905de362@physik.fu-berlin.de>
Date:   Sat, 6 Feb 2021 17:07:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205220618.611388-1-enbyamy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 217.247.72.48
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amy!

On 2/5/21 11:06 PM, Amy Parker wrote:
> Some statements do not have proper spacing between their C
> keywords (commonly if and for) throughout files in the ia64 tree.
> This patch corrects this to follow the kernel code style guide.
> 
> Signed-off-by: Amy Parker <enbyamy@gmail.com>

I never noticed. Does the kernel coding style guideline actually require
space after "for" and "if" and similar statements but not before function
names?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

