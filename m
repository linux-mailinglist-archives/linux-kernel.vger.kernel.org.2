Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68135AD01
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhDJLhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:37:48 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:12625 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234431AbhDJLhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:37:46 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8EyCK6A21whjpfXlHegZsceALOonbusQ8zAX?=
 =?us-ascii?q?/mp2TgFYddHdusC1hfIA1QL1jjF5YgBQpfmrPq6cTXTAsaNv6Y4KMru4GCXgsm?=
 =?us-ascii?q?2kLIZthLGSigHIMSv46+JbyONcY7FzYeeARWRSoOTbxE2DE9gmyMSa66zAv5a7?=
 =?us-ascii?q?815BRRxnApsQlTtRJwqfElJ7XwVKQac+faDw2uNqvCGnYm5SU8LTPAhPY8HtvN?=
 =?us-ascii?q?vO/aiWFiIuIz4CxE2wgSiz6Lj8eiLooCs2dz9U278t/SzkvmXCl9iemsihxhXR?=
 =?us-ascii?q?2mPV5Zg+oqqU9vJ5CMaBitcYJ1zX427CCOsROczmzVdFxpDXmS5a6+XkmBsrM8?=
 =?us-ascii?q?Rt536URFibyCGduDXI6zo27m+n9FnwuwqUneXCSDU2B9Epv/MSTjLi90EisNtg?=
 =?us-ascii?q?uZg7rF6xipw/N2K9oA3A/dTSEzllmk2oyEBS7tI7vjh1XYcYVb5ctoB3xjImLL?=
 =?us-ascii?q?4wWAbz6IUiGO4rJNjE//BIfV7fR22xhBge/PWcGlA6HhKDSk9HhcCPyThRmxlC?=
 =?us-ascii?q?vj4l7f1auGwB+pI7Q5wB2uKsCM5VvYALceMsUIJWLMJEYfLyMnDEWhrKLWKULR?=
 =?us-ascii?q?DGOcg8VU7lmtrJzI4JxMuDXdgp9d8Jsrznd3903FRSR2veTfKj56Bq2DjpBEWF?=
 =?us-ascii?q?GQ71wsUb3ZJ+obGUftrWDRE=3D?=
X-IronPort-AV: E=Sophos;i="5.82,210,1613430000"; 
   d="scan'208";a="502547776"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 13:37:30 +0200
Date:   Sat, 10 Apr 2021 13:37:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the
 type and use of a variable
In-Reply-To: <10115279.QsZogQpAqX@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2104101334190.2975@hadrien>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <4547533.LBOHeWh67L@localhost.localdomain> <YHGGBpSLj+W8ikXz@kroah.com> <10115279.QsZogQpAqX@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That variable has global scope and is assigned at least in:

What do you mean by global scope?  None of the following look like
references to global variables.

julia

>
> drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:368:
> pwrpriv->fw_current_in_ps_mode = false;
>
> drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:380:
> pwrpriv->fw_current_in_ps_mode = true;
>
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:433:
> adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
>
> drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:981:
> pwrctrlpriv->fw_current_in_ps_mode = false;
