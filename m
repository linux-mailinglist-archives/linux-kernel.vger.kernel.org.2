Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3714424CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbhJGGFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:05:05 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:36821 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhJGGFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:05:02 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E2CE252;
        Wed,  6 Oct 2021 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633586589;
        bh=BMDC3Op7w/U0rIg38TVt+UVWdc8mvdr7eIpHHCG/AdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wy70ZNaE+bRqJ+L8pts4q6urOnfg6qnsoWv2oYdXjwlnW6h7wT29/4rfHkq8hVVm6
         C1v5YmX6sEpnVEa0YBd9BL7ywbB98xJwyWCG4zEmlPV67NjzOZoONdsSnBI0uws8z0
         X9uzLIyHHpQU+SOYPpXUCHg9L2LnAmuHWjK/Y/4M=
Date:   Wed, 6 Oct 2021 23:03:07 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] dt-bindings: document new 'dynamic' common property
Message-ID: <YV6Nm9jVeZ5Adte5@hatter.bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-9-zev@bewilderbeest.net>
 <YV6FEisHXqdBuduZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YV6FEisHXqdBuduZ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 10:26:42PM PDT, Greg Kroah-Hartman wrote:
>On Wed, Oct 06, 2021 at 05:09:53PM -0700, Zev Weiss wrote:
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
>I know I can not take patches without any changelog text.  Maybe other
>maintainers are more "lax" :(
>

Okay -- for this one I wasn't sure what to put in the body that wasn't 
basically just duplicating the subject line or the content of the patch, 
but I'll make sure to put something there in the future.


Zev

