Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123E2459E60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhKWInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbhKWInl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:43:41 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7900BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:40:33 -0800 (PST)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id BC281275DD6;
        Tue, 23 Nov 2021 09:40:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1637656831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iCU+5NTEu01/mExPkv+DECsXCxInEDrQAaJdd4Q5YI=;
        b=717jTv3hevhezmDegnmreqrJhoizE674KP+jok+fU03Y2opc41aq8oBWZRRuda1t69MaOL
        dT7Lzt+CpckCg9yLm4V5m9Xml5TTdbptMQ5ow52P7dojhPP/UtNoVgjfumIKEvn5kt9BC6
        n0rClVm8EMA0heHI8kFy20EhyfIhMa48Q2eu5XKxGI3tllPSh7TYGk84eiL3PoHdkmFHNp
        ganQ3fF4Kx+K+/+9zdpVzHWh62qGwPnzS22aEJmDW5ZqPK7IpiXrWTb4ll2mwpKK83izpP
        C7UW1IEozcjw0X+vgqEyHL7FS4WyMkafTYS7+BLhVKCqn2e4xWYeUlpFwu+X0Q==
Message-ID: <39e2b51913ef6049103d3cb67df9048514c12484.camel@svanheule.net>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     kernel-team@android.com, Rob Herring <robh@kernel.org>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Tue, 23 Nov 2021 09:40:29 +0100
In-Reply-To: <20211122103032.517923-1-maz@kernel.org>
References: <20211122103032.517923-1-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, 2021-11-22 at 10:30 +0000, Marc Zyngier wrote:
> Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> to an interrupt controller"), a handful of interrupt controllers have
> stopped working correctly. This is due to the DT exposing a non-sensical
> interrupt-map property, and their drivers relying on the kernel ignoring
> this property.
> 
> Since we cannot realistically fix this terrible behaviour, add a quirk
> for the limited set of devices that have implemented this monster,
> and document that this is a pretty bad practice.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Biwen Li <biwen.li@nxp.com>
> Cc: Chris Brandt <chris.brandt@renesas.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks for the patch. As far as I can tell, this restores the old behaviour from
5.15 for "realtek,rtl-intc" and things work as expected.

Best,
Sander
