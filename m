Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA636C841
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhD0PGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhD0PF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:05:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27A9761178;
        Tue, 27 Apr 2021 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619535914;
        bh=v5U4mUr4UALNU8p56i3DOzDfcVR28sMSJC2daVo3NnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoJDDrO0R+1JC5SwG8srBDphbX0Nm+yfxkBekisAcAHxi4UHSX9en5QgZ7Py+mNhN
         gKZ1lWlts4XawV7gBsW8aLTDctrGFqT7TOlutdulDOXD+OL53zOsm3zSrWN3mOQms4
         IqA65Dic3saBWYVwldAIaPEnZCy4v0byKfrEbKgqXKRNueAc6cltqRIJkDOr+S4jYq
         7tLCFB+ERvlPJnNNBEbgAOwhyTKXI85dpeVyND72c/plT9Y404P1FpMkw7x39KwMD0
         A6s4xWCecLb7telhCZgwFAkGXsPQD9ibmyR4hPehj55mEu3WmDiRkkFJQiH+2MD5WN
         sO3NJlRIiAo9A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lbPHE-0002y9-0q; Tue, 27 Apr 2021 17:05:28 +0200
Date:   Tue, 27 Apr 2021 17:05:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v3] coccinelle: api: semantic patch to use
 pm_runtime_resume_and_get
Message-ID: <YIgoOH04vO3KPSBs@hovoldconsulting.com>
References: <20210427125834.2477467-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427125834.2477467-1-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 02:58:34PM +0200, Julia Lawall wrote:
> pm_runtime_get_sync keeps a reference count on failure, which can lead
> to leaks.  pm_runtime_resume_and_get drops the reference count in the
> failure case.  This rule very conservatively follows the definition of
> pm_runtime_resume_and_get to address the cases where the reference
> count is unlikely to be needed in the failure case.  Specifically, the
> change is only done when pm_runtime_get_sync is followed immediately
> by an if and when the branch of the if is immediately a call to
> pm_runtime_put_noidle (like in the definition of
> pm_runtime_resume_and_get) or something that is likely a print
> statement followed by a pm_runtime_resume_and_get call.  The patch

s/pm_runtime_resume_and_get/pm_runtime_put_noidle/

> case appears somewhat more complicated, because it also deals with the
> cases where {}s need to be removed.
> 
> pm_runtime_resume_and_get was introduced in
> commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter")
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
> v3: add the people who signed off on commit dd8088d5a896, expand the log message
> v2: better keyword

Johan
