Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5D319AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBLH7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhBLH7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:59:51 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 23:59:10 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w36so11880841lfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 23:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X90yKEHaFzBD5XN2J2evDu2Gp989HIcVHi/aqeOnUag=;
        b=ELYWasRbBCZHGdd2JDHquth5nceCOQqWDsUmhUbwKiY6qYAP8JlfXJk+HCFV6v4rPV
         IM9il0fVPTi+Yg6WcpeekLDqUPBdApciMQP6EV7kLrOrt9NMO9zgGWWP2qEzeGJcsXCu
         T/kHng+5/tiI6Aao/u6E5j32FPjuwB48ljU8hETW8S2MQ8H83Na6zLfQUkI+V0VsqNeH
         2ENIXhZ8mVn5UeWc38lpHUEgEKEfWFp0yQWPyfdLrRYwFierbV2FF9Vrmi/rCSx3q1CG
         WN1/V6JYfaPSEuiIDOsXzpExMKLt69yzh8G6qsJHkk00TfXCNzDM5Au8nNi9HJwA5+0w
         /gUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X90yKEHaFzBD5XN2J2evDu2Gp989HIcVHi/aqeOnUag=;
        b=luvHV5pZfnMVG65zsFsMSjeslXJYBH/8Jx1spDbJqRi0ZfghMAKF6XqbI8wXXDcugz
         ucKhuwHZAztIvyRx0rUWI9xy7j0SCUMpzNsHyAO7yKSgSHVP3M4nNbHk+8FQHxN4OWum
         0t1DdJxemn/aSmLXm7jnNivlQBFy8rkEnYtY/6cp7v+7Zv0T4Akc7p/oRy6imP54TrXL
         HPH0Wi6hjKCCwgavvOfnVi8p7qjQ281SRsoVMBmwHyakMn6iTdZFK9BoGC+NSsQjvP9h
         2a1eoERm9CuoUmuLq0bmhYXSTCXH8xff7GaWXPemBsxmpQA/CU0W5oudUzdpkQaVLPVC
         WBXg==
X-Gm-Message-State: AOAM530SwsJl7tQ4oYDGAXTn3u4E3z1EFFeG8332hGtYnoEm4sll3o9E
        xUCDBhwePLwJDSfLMJHYhf8GQcy+/C4mov3HTYHeiA==
X-Google-Smtp-Source: ABdhPJz2NstJRrr8mkZHm31iCPXb/pThSL6cNX8TF0QlsPKUVxv6z6DPc9jEd2R6GRC0ysYCmxVZHKHIWipQrB8wgwU=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr917644lfd.291.1613116749072;
 Thu, 11 Feb 2021 23:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20210126044742.87602-1-drew@beagleboard.org>
In-Reply-To: <20210126044742.87602-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 08:58:58 +0100
Message-ID: <CACRpkdbcOvOS4OSZt8cAWV7+-D8sHN7HWhrxGLU7fqKiwB1CCg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: use to octal permissions for debugfs files
To:     Drew Fustini <drew@beagleboard.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 5:55 AM Drew Fustini <drew@beagleboard.org> wrote:

> Switch over pinctrl debugfs files to use octal permissions as they are
> preferred over symbolic permissions. Refer to commit f90774e1fd27
> ("checkpatch: look for symbolic permissions and suggest octal instead").
>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

That's right. Patch applied!

Yours,
Linus Walleij
