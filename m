Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154F236C6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhD0NTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhD0NTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:19:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB579613B0;
        Tue, 27 Apr 2021 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619529512;
        bh=LWjtx1WQZ8AKHRGhYes2jCOqJ26s9v2b9O0/NeUEk8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u740M1fN7z/w2G5QCSYJ90lBSKMo6zBq889I3ePN3wL+/hteNyww280mHh6xU/ULG
         nI1eaX0ApQhwFSKFHcavIjr5AOjbkvL/nihBp9o1ycglsQLYEtPcDZYq87NZyNUznx
         yad4P4DxzSY5mDNX2LcfXv4Hcz/9J33leAyHFRjD2+f7Eu/QXJIUnuEg/bjOanaMhO
         eGHOc5YC6Vo5wwcxgsyA8m1d17E8VAvtaCTXJH9MtHg70Yu6/GfV/9IckN5Z3BCLX7
         +89EEJ/KDI5B6T8fRWK1YVnvYh9Q+H5g2LZfM67ZhBzONLOHd2xvQhVEFEZZ+O2qJ3
         8fPB45ejz1Byg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lbNbx-0002i9-MA; Tue, 27 Apr 2021 15:18:46 +0200
Date:   Tue, 27 Apr 2021 15:18:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coccinelle: api: semantic patch to use
 pm_runtime_resume_and_get
Message-ID: <YIgPNRiaz2Jup+PT@hovoldconsulting.com>
References: <20210426185404.2466195-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426185404.2466195-1-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 08:54:04PM +0200, Julia Lawall wrote:
> pm_runtime_get_sync keeps a reference count on failure, which can lead
> to leaks.  pm_runtime_resume_and_get drops the reference count in the
> failure case.  This rule very conservatively follows the definition of
> pm_runtime_resume_and_get to address the cases where the reference
> count is unlikely to be needed in the failure case.
> 
> pm_runtime_resume_and_get was introduced in
> commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter")
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

As I've said elsewhere, not sure trying to do a mass conversion of this
is a good idea. People may not be used to the interface, but it is
consistent and has its use. The recent flurry of conversions show that
those also risk introducing new bugs in code that is currently tested
and correct.

By giving the script kiddies another toy like this, the influx of broken
patches is just bound to increase.

Would also be good to CC the PM maintainer on this issue.

Johan
