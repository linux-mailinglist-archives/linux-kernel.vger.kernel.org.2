Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50BF3A1733
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhFIO2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:28:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50770 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhFIO2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:28:38 -0400
Received: from nramas-ThinkStation-P520 (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0542020B7188;
        Wed,  9 Jun 2021 07:26:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0542020B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623248804;
        bh=h6o44sXR20MBpD+68d/AtJ1ddf69cXVZqeVwg1gbIAw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mJQ9RnRCDVgK3F65SYWwV64HUQOte0w0a7lwaDXRBz/BXDWWtDO5mmBGZUDE0anOK
         2zOc/pWCUAtwT1MlUXV4U1STazdPHwZjEsQD0FNO+iTXqpnBEF9Sl87Do6DJj/BsXo
         Tlu3E7wWWqoxuyM3kRVI92HL9Pm/qzxQNbXhliLY=
Message-ID: <f5579d401738d5c72b359a158c825e5c2bc3e746.camel@linux.microsoft.com>
Subject: Re: security/integrity/ima/ima_kexec.c:81:6: warning: no previous
 prototype for function 'ima_add_kexec_buffer'
From:   nramas <nramas@linux.microsoft.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date:   Wed, 09 Jun 2021 07:26:43 -0700
In-Reply-To: <202106091229.uCfgCAOZ-lkp@intel.com>
References: <202106091229.uCfgCAOZ-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-09 at 12:10 +0800, kernel test robot wrote:

Hi,

>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> > > security/integrity/ima/ima_kexec.c:81:6: warning: no previous
> > > prototype for function 'ima_add_kexec_buffer' [-Wmissing-
> > > prototypes]
>    void ima_add_kexec_buffer(struct kimage *image)
>         ^

"linux/ima.h" needs to be included in
"security/integrity/ima/ima_kexec.c" to fix the above warning.

Thanks for reporting. I will post a patch shortly.

 -lakshmi

>    security/integrity/ima/ima_kexec.c:81:1: note: declare 'static' if
> the function is not intended to be used outside of this translation
> unit
>    void ima_add_kexec_buffer(struct kimage *image)
>    ^
>    static 
>    1 warning generated.


