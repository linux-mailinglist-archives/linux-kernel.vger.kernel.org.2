Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DFE39AFFB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFDBq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDBq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:46:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA67C06174A;
        Thu,  3 Jun 2021 18:44:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Fx5D56k9rz9sRN;
        Fri,  4 Jun 2021 11:44:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1622771078; bh=50EfJBKU4bDP6I7XQlD6MYVj4+vj2dewObOhR7914Hc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TXlPT6/gCsrrWKtg+AgmkQAsYIWLbvR1rXPJaOqHtLIUvxF2XbpgDXYFVDIz0KL5u
         dAOuYCEW98Pddbsp5VIzhpLztLwLuNiqU82nnPq/1uUab8LQ2CGaUpZQIkHnsrj/GJ
         CUYeyGz48DdxGycblLBWNMKzeNUtP9lhFdMnja+HEyK/tyjOKjFtOqRiq7Dwh0zOoT
         KhqTjgk5s+63gX65a7VQlSeB5g3C7GYgwS2Tcny2wIj2oPRbF8t7gCnlfshtJDJIDp
         9HRpH2VuICH5Kr5VJLfMYdVy3VlI898o9Mab1T/IuP08bfkw5TOADOQIf+zJ26xieQ
         MBPDnG5TaJB8A==
Message-ID: <bc45bf20461fda09e7b224465285f1385cdab09b.camel@ozlabs.org>
Subject: Re: [PATCH] fsi: core: Fix return of error values on failures
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Colin King <colin.king@canonical.com>,
        Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fsi@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Jun 2021 09:44:33 +0800
In-Reply-To: <20210603122812.83587-1-colin.king@canonical.com>
References: <20210603122812.83587-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,
> Currently the cfam_read and cfam_write functions return the provided
> number of bytes given in the count parameter and not the error return
> code in variable rc, hence all failures of read/writes are being
> silently ignored. Fix this by returning the error code in rc.

Looks good to me, thanks for the fix.

Reviewed-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy

