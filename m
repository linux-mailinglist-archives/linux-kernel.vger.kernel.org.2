Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0594329FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbhCBDps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbhCAUyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:54:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DD3C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 12:53:41 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id x20so19515161oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E+w0HAJylkgq3bPjmsNmLQYaODZeNQostL0eaoslM0E=;
        b=nG1cyFoOya0gLfDU17JGUVlLtP7ziwoWqYEXcgHf7KJBnFebdR6zeVan7zaHINkps0
         KafE7lYrUUx47bDa91ImCZbW0vkqS5A0T6dNldh78YZZ1PEUH8f4ny+uCVIRZCeS/6hp
         vbGAuZo7eqv03BlMTqPZQlRLGRcQ8GsNgtYbHUOyaiJK4G+yaTm+HlxI4dbCiyxcXQYM
         yFdoTvdPuEL4KhEu2H7mGX1MCYZ8OtkLn6XWcPyaWRhER1s6kYGHemRhClPVREhCrG5t
         9xM/HmB+DYdtzv9FPiGKgzkJfd+c02dlNh1E2C6AOyIYnoQjr/5CZdO2tYdA0iF2BE5w
         G0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=E+w0HAJylkgq3bPjmsNmLQYaODZeNQostL0eaoslM0E=;
        b=cnggOizNZZkldErZ3aYUJ6Pf91a2yAPqdk9L2ESVWhG814yfPjClKNEqGSTvf8Odyd
         yMUM+X1qo3uyTYyEbMMukAw/NjHkSElCSV8mAj5HlHNlqIatSaf7fr235B4UHjFzyt2h
         dvtnseBbYwV2Ejtvt/1JpNVQdMVApouwBU4QlLSVyFtsmwJbeB/Jp3eFwM44V9qy95GJ
         W31x6ysWuGradLgDLOosDkcTc8U/ikQ3iLEAn77VTiw4gPtKhuvTZlyxSZnwtxK52/H8
         oeha48b6oc2xHTf+fZluRzPqRyWeGyLI9G9e172rM4JtEyukZfD0qAwtPS6JQAEdmVhK
         vc/g==
X-Gm-Message-State: AOAM530S8d2ZAWHXwlazcnjzlcnuekP2sqycJZPJqIlaN28VPvRUlEAi
        f4Gv56C8FhXSRzf0ELCSWZy0HZzCFAU=
X-Google-Smtp-Source: ABdhPJyBRtDJc+DINRoicRMHJSEYwSvw4iqujDc3L6cFHcuEm/oifvNHUJw25DE0ws6yBypLlD84JA==
X-Received: by 2002:aca:ad0d:: with SMTP id w13mr684782oie.170.1614632020715;
        Mon, 01 Mar 2021 12:53:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k18sm4016979ots.24.2021.03.01.12.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Mar 2021 12:53:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 1 Mar 2021 12:53:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12-rc1
Message-ID: <20210301205338.GA74835@roeck-us.net>
References: <CAHk-=wjUzNbTuRCAv80vyD1dXEEaefdpRi23J+suSaognBoV8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUzNbTuRCAv80vyD1dXEEaefdpRi23J+suSaognBoV8A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 04:29:34PM -0800, Linus Torvalds wrote:
> So two weeks have passed since the 5.11 release, and so - like
> clockwork - the merge window for 5.12 has closed, and 5.12-rc1 is out
> there for your perusal.
> 

Basic test results look pretty good.

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 435 pass: 435 fail: 0

Guenter
