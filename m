Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3080839D925
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGJ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGJ5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:57:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 530EE6008E;
        Mon,  7 Jun 2021 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623059740;
        bh=VpiaPJbhhIcgtoDeUX/ziiaSfilXdpI7+CrehsiN4tQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AVbYgirrv0f14aId0ukds9/2fCavM0VHvrPpsuN8lw54NpczPthBTn1ysioMLwnRm
         mXee38XO1G3LerArnEg/0I2HJwYK0QJw47O+fiwLrJzMaHHudhqhmPZSZ3+by7lcwi
         K5PpvLcTXi39LrUH7au4n8lSmIU7/6yUUierI+QVXWNiqKrH9gSDsnGpfkVAqVzMhu
         QEI8nZ1EsSsREmgHseDb/ODbGVplMkE9KOB+N9UeDDy5bkEODaupCJolCBQ1du3PkS
         +9QWK+r5/0DbeKmzFEoFbl03ddAyKpSEJcO9r9+UElgkmE8VcWrsqUQ5AMn1wgZY3A
         /HVlU/2VAn+7Q==
Date:   Mon, 7 Jun 2021 11:55:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/34] docs: driver-api: surface_aggregator: avoid using
 ReSt :doc:`foo` markup
Message-ID: <20210607115535.0181e679@coco.lan>
In-Reply-To: <1663da2c-571f-cf7d-a0ca-ea7031515b40@redhat.com>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
        <c42fe427e6538ce7914645468ef63f83254c26d7.1622898327.git.mchehab+huawei@kernel.org>
        <91d72412-3bba-8a50-4527-7c8fb9fa54c4@gmail.com>
        <1663da2c-571f-cf7d-a0ca-ea7031515b40@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Em Mon, 7 Jun 2021 11:31:49 +0200
Hans de Goede <hdegoede@redhat.com> escreveu:

> Hi,
> 
> On 6/5/21 4:14 PM, Maximilian Luz wrote:
> > On 6/5/21 3:18 PM, Mauro Carvalho Chehab wrote:  
> >> The :doc:`foo` tag is auto-generated via automarkup.py.
> >> So, use the filename at the sources, instead of :doc:`foo`.
> >>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > Acked-by: Maximilian Luz <luzmaximilian@gmail.com>  
> 
> Mauro, I assume that you are going to take care of sending this
> to Linus, or do you want me to merge this patch into the pdx86 tree?

Whatever works best for you and Jon, as it should either be merged
via each maintainers' tree or at the docs tree ;-)

Regards,
Mauro
