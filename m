Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A607326223
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBZLtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBZLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:49:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DA8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:48:28 -0800 (PST)
Received: from zn.tnic (p200300ec2f086900dfbc884e5f24c36d.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6900:dfbc:884e:5f24:c36d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E07691EC038E;
        Fri, 26 Feb 2021 12:48:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614340107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Kdgy2RXJ2A00wGzw/dGKKYDFkMjnXtbb6c45QRkooTw=;
        b=kLhxjYLgDkA67QwYqME5mz7/MYFCvVuEH4R3Xl/sEaZzNRWdc4+F8Fm7pVFSYO2LLE7Shx
        zQVaTGjpLuHDB/eg77g8jbXj18gpS5Y3JFcbnfk/PyPbnTEYqcYhAbtyAXA7yD1ims2ntx
        p6W+B6mQNpwLvuGjCElm4usKjA1pnLQ=
Date:   Fri, 26 Feb 2021 12:48:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, mbenes@suze.cz, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/3] objtool: Add --backup
Message-ID: <20210226114819.GC19284@zn.tnic>
References: <20210226105742.844988140@infradead.org>
 <20210226110004.133170708@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210226110004.133170708@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:57:43AM +0100, Peter Zijlstra wrote:
> +static bool objtool_create_backup(const char *_objname)
> +{
> +	int len = strlen(_objname);
> +	char *buf, *base, *name = malloc(len+3);
> +	int s, d, l, t;
> +
> +	if (!name) {
> +		WARN("failed backup name malloc");
> +		return false;
> +	}
> +
> +	strcpy(name, _objname);
> +	strcpy(name + len, "bj");
> +
> +	d = open(name, O_CREAT|O_WRONLY|O_TRUNC);

Yah, as mentioned on IRC and let me paste it here too, you need to
supply mode with O_CREAT:

	d = open(name, O_CREAT|O_RDWR|O_TRUNC,S_IRUSR);

or so. Also you could add perror("open") to those error paths so that it
can say why it failed creating the backup file.

With that, thanks for doing those!

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
