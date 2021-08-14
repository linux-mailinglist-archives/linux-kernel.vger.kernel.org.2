Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33F33EC36C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhHNO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:59:49 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:36994 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhHNO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:59:49 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEv5u-00BilX-4v; Sat, 14 Aug 2021 14:57:06 +0000
Date:   Sat, 14 Aug 2021 14:57:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <YRfZwrJUutB4IO+G@zeniv-ca.linux.org.uk>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
 <YRfVYxQ126AOuexl@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRfVYxQ126AOuexl@unreal>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 05:38:27PM +0300, Leon Romanovsky wrote:

> There are number of reasons why you didn't notice any difference.
> 1. {} is GCC extension
> 2. {} was adopted in latest C standards, so need to check which one GCC 10
> is using by default.
> 3. Main difference will be in padding - {0} will set to zero fields but
> won't touch padding, while {} will zero everything.

References on (3), please?
