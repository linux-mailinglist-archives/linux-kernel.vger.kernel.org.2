Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E0035AD36
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhDJMMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 08:12:45 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:27234
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231279AbhDJMMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:12:44 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Akl16mapN9b9TyCOZpprLQYcaV5rzeYIsi2QD?=
 =?us-ascii?q?101hICF9WMqeisyogbAnxQb54QxhO00ItNicNMC7K0/02oVy5eAqUIuKeCnDlC?=
 =?us-ascii?q?+WIJp57Y3kqgeBJwTb+vRG3altN4hyYeefMXFAgcz34Ba1Hr8bqbHtzImSif7a?=
 =?us-ascii?q?3zNRS2hRB51I1RtzCQqQDyRNJTVuOJxRLvWh2vY=3D?=
X-IronPort-AV: E=Sophos;i="5.82,210,1613430000"; 
   d="scan'208";a="378283903"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 14:12:29 +0200
Date:   Sat, 10 Apr 2021 14:12:28 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the
 type and use of a variable
In-Reply-To: <2763630.ZYQqkGPH9U@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2104101410350.2975@hadrien>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <10115279.QsZogQpAqX@localhost.localdomain> <alpine.DEB.2.22.394.2104101334190.2975@hadrien> <2763630.ZYQqkGPH9U@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Apr 2021, Fabio M. De Francesco wrote:

> On Saturday, April 10, 2021 1:37:30 PM CEST Julia Lawall wrote:
> > > That variable has global scope and is assigned at least in:
> > What do you mean by global scope?  None of the following look like
> > references to global variables.
> >
> > julia
> I just mean that fw_current_in_ps_mode is a field of a struct in a .h file
> included everywhere in this driver and that the functions whom the
> following assignments belong to have not the "static" type modifier.

OK, but a field in a structure is not a variable, and this is not what
scope means.

int x;

outside of anything is a global variable (global scope).

int foo() {
  int x;
  ...
}

Here x is a local variable.  Its scope is the body of the function.

int foo() {
  if (abc) {
    int x;
    ...
  }
}

Here x is a local variable, but its scope is only in the if branch.

julia

>
> Thanks,
>
> Fabio
> >
> > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:368:
> > > pwrpriv->fw_current_in_ps_mode = false;
> > >
> > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:380:
> > > pwrpriv->fw_current_in_ps_mode = true;
> > >
> > > drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:433:
> > > adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
> > >
> > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:981:
> > > pwrctrlpriv->fw_current_in_ps_mode = false;
>
>
>
>
>
