Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0134F3D21E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhGVJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:31:43 -0400
Received: from foss.arm.com ([217.140.110.172]:49694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhGVJbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:31:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DE59106F;
        Thu, 22 Jul 2021 03:12:17 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8172B3F73D;
        Thu, 22 Jul 2021 03:12:16 -0700 (PDT)
Date:   Thu, 22 Jul 2021 11:11:17 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] MAINTAINERS: update arm,vic.yaml reference
Message-ID: <20210722101117.5anhjut6djso2ojr@bogus>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
 <7dbff9673e8703cd60e78f8b2110349d86d60a87.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dbff9673e8703cd60e78f8b2110349d86d60a87.1626947923.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:00:02PM +0200, Mauro Carvalho Chehab wrote:
> Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
> to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.
> 
> Update its cross-reference accordingly.
>

Thanks for fixing this.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
