Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027E73829E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhEQKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:35:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:55169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhEQKfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:35:43 -0400
IronPort-SDR: dEODysTLwW18TnWVx6i7gof7NnxkWnLRbvE5x6AWNBP/C08SvU1MTaYinggBrOothbJZ5mFjmo
 xb/4cuh6E72Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="180711834"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="180711834"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 03:34:27 -0700
IronPort-SDR: qgqSUB9eX+KpufJfbo4qLg4Hyv8wKGBn0CWGlOJGrHITZbuOvdw/M0lB4BXPghtLsdr4BZHj5s
 atdMTl5uUUtA==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="393470428"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 03:34:24 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1liaZo-00CiTM-CX; Mon, 17 May 2021 13:34:20 +0300
Date:   Mon, 17 May 2021 13:34:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, pizhenwei@bytedance.com,
        pbonzini@redhat.com, linqiheng@huawei.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] misc/pvpanic: Fix error handling in
 'pvpanic_pci_probe()'
Message-ID: <YKJGrGTHz+DzfiHN@smile.fi.intel.com>
References: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
 <YKIi1hljnjvqMCVA@smile.fi.intel.com>
 <ada55e25-5eb3-9b6b-5783-d2303db9bf83@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ada55e25-5eb3-9b6b-5783-d2303db9bf83@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 12:02:24PM +0200, Christophe JAILLET wrote:
> Le 17/05/2021 à 10:01, Andy Shevchenko a écrit :
> > On Sun, May 16, 2021 at 04:36:55PM +0200, Christophe JAILLET wrote:
> > > There is no error handling path in the probe function.
> > > Switch to managed resource so that errors in the probe are handled easily
> > > and simplify the remove function accordingly.
> > 
> > Yes, that's what I suggested earlier to another contributor.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thanks!
> > 
> > P.S. You may consider the following things as well:
> >   1) converting to use pci_set_drvdata() / pci_get_drvdata()
> 
> I can send a patch for that if you want.
> But it looks really low value for a driver that is already very short and
> clean.

Yep, that's why 2) below came to my mind (then you will remove drvdata call).

> >   2) providing devm_pvpanic_probe() [via devm_add_action() /
> >      devm_add_action_or_reset()]
> 
> I don't follow you here.
> The goal would be to avoid the remove function and "record" the needed
> action directly in the probe?
> 
> If this is it, I would only see an unusual pattern and a harder to follow
> logic.

> Did I miss something?
> What would be the benefit?

First of all it's a usual pattern when one, often used in ->probe(), function
gains its devm variant. See, for example, `return devm_gpiochip_add_data(...);`
used in the code.

Benefit is to have everything under managed resources and yes, no ->remove()
will be needed in the individual drivers.

But it's up to you. It was just a proposal that you may simply refuse to follow,
it's fine.

-- 
With Best Regards,
Andy Shevchenko


