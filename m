Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3C4292AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbhJKPBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhJKPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:01:21 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75043C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:59:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w10-20020a056830280a00b0054e4e6c85a6so12993792otu.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gED/Zj4jH4IwDuyO5wsoRfzqKSsSFzXH+e1v61d2Mmo=;
        b=DPwkcGjU4QkwpvOgzJtDsJRALyVsfbOAlW8LxqvXLHbfOfjxdCICRLNN1+B75iNILi
         rxG1Kxo6t4MlkHpzHJZO2lsAnHlEbgIYOyW8nkhmShs3X42BqOoIGnF7opJKIg12my78
         qMevuCZXykWLJ8ZFy8nUYH7H1Lt5losNlhW4w0Qps6wiwFN2ZJQG/4kHA+G3jnPtZIav
         c30qo60+NBjET1LnfnNwsZbzblNrKlQ10aXIzkjO72BvQJvymxgaXO/eBqDrQbpMB70P
         54O83hxfS5ueqQrpIFfgtNcATltPp+lYqi1uO641j8Zgwi+T3ym5gIgwR6KGDrC03OwI
         jDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gED/Zj4jH4IwDuyO5wsoRfzqKSsSFzXH+e1v61d2Mmo=;
        b=LhaaSSUUOtkWVmtqKldMZvn8Lf7WF3cBI5ctuzh9Ycf+E/TS1XfsU6t4N7Vzil4SkF
         Jhi+G4Ud+Zqegf77bHXlcdO73Pa9kaoJJAgBvKH4DTTg8ULPxtnqqH/1IExKEqYO6931
         npbR0klcDA12vzSqucmOIFpjNbeKpS43f7PRtVoSVSuQTniW5N2ZmlI9qdvQHVO6LGMw
         KtChiCknT6HzUKMe2lGVQsOmADF5j42RtisEY6jaEXSTkakxG6yzDjwwAChETmPVn8j8
         GKjr2XB3op2UXehI1UPMkMka+keZYJ3QOxeFQ9zpHH6aE8jRS97S5xwk0G71zV5DFcRp
         zhPw==
X-Gm-Message-State: AOAM533IguNqRdgPxjz/1HPIqZeJtMTVBKDWBXiR/Rq/iVTHCeQayOB+
        SKNWYHUkvN+/93ftmoU2XYy91tTOXu0=
X-Google-Smtp-Source: ABdhPJwgbjhotfJu+5ghALEH9TWAzaLsKMIiyeaoBsSTuofjY9zhg6ZqUFYYXMyhSXpCqoP/VsBpyQ==
X-Received: by 2002:a9d:6f93:: with SMTP id h19mr21472680otq.14.1633964360799;
        Mon, 11 Oct 2021 07:59:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm1536545oof.47.2021.10.11.07.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:59:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Oct 2021 07:59:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc5
Message-ID: <20211011145918.GA3305747@roeck-us.net>
References: <CAHk-=wiTZxkHVg=Pz7XRd-9AEDp0qV5sWmQJWnQ4NrSPYRHNiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiTZxkHVg=Pz7XRd-9AEDp0qV5sWmQJWnQ4NrSPYRHNiA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 05:16:09PM -0700, Linus Torvalds wrote:
> So things continue to look quite normal, and it looks like the rough
> patch (hah!) we had early in the release is all behind us.
> 
> Knock wood.
> 
> The commit stats look normal for an rc5, and the diffstat is fairly
> regular too. We had more arch updates than perhaps is common, with
> almost as many lines of diffs in architecture code as there is in
> drivers.  Admittedly some of that "architecture" code ends up being
> devicetree updates, so some of it could be attributed to driver code,
> but that's not how our source tree is laid out..
> 
> Outside of arch code (x86, powerpc, arm, arm64) and drivers (mainly
> gpu, networking and usb), we have a smattering of other changes: 9p
> and ksmbd, core networking, and some perf tooling updates. And misc
> smaller random stuff.
> 
> Shortlog appended for more of a flavor for the details. Please do give
> this a whirl,
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 480 pass: 480 fail: 0

Guenter
