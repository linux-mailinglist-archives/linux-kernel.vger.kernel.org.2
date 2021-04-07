Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF943564CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhDGHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDGHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:11:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E00EC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:11:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso593816wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x+hJP4Wbd0+kr+Q6ctN5XNabEooWKMdvmI401MEJJ8I=;
        b=sLMhvI3zLplhs6Z+gGg+ktSXOZzTrXE7tvrf/IxD5gIZ5csmkPwfMh8RwTFoemaGdU
         8q2ACC5Ueb197JzanKYe7fUhgRjP/HyalCwaCz+7M3lqKzLAOosQbJgJmkExjWSiGnAt
         GDKPVjO301ASIrC3qRB85d21vdnvHhHYu4VVrbteUCIGEHTMAuoW8V2eWknakk0E1rc8
         Cw3WQDLLOmaxVOFdBnikTB0azuGa+UeKdRZJ24sTRDwcTYont2VO4fr1bbYqjsWWLbhd
         A15hB7UlwVndqNLj9R0o9zj64+dEXwtYmfXHRilYy8rTTycyjY0HKDO73Anm1wbOwN/J
         2RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+hJP4Wbd0+kr+Q6ctN5XNabEooWKMdvmI401MEJJ8I=;
        b=oEbtnqFLqk6zi4GgnrKOWDlKXZSRBqu7JnrPGQpHK2jrnm3EQ9ZMdiasr4r5ulcoer
         i8Ti+9nO5nqUcntcAdqYFEsYS8I0H+UsADfyUn6n/TcaUjmk/2tSWb2BbJDxxP5L3m/G
         aAay0zQ0pk967ggxcZPvLCykX+o9vUx+6k0zMEQJ/RQaWicG8vt1I0LiabwnbSaX36KB
         bdZohcD3xFQFxqwX/pge1xOl+qYCvA/lalCctRSPLvKsiU5LV3i5cBXJUw0ng5go7kJD
         oIAUpuYAlpYSpUANe/xs1iO6frmaySB+s4Q0yY4yGFCd9/gW2jubKI270faHHlbqevLx
         4F6w==
X-Gm-Message-State: AOAM5314jdkIs+AN5cn9asCgFTP6m4Ff0YImU3mnCresZI8wT0Xggng5
        R8OANhZoC03m0WHhhSMB7PRLRNuuKwY9xA==
X-Google-Smtp-Source: ABdhPJyVQRgco5fyWoJmXb4S9xrDYaQnwBqKdQfg0JhjtHIHEqHDUciLVxKHjOUfJf/pqZfN8SzEWQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr1618228wmg.171.1617779481909;
        Wed, 07 Apr 2021 00:11:21 -0700 (PDT)
Received: from agape.jhs ([5.171.81.184])
        by smtp.gmail.com with ESMTPSA id y17sm7864224wrw.1.2021.04.07.00.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 00:11:21 -0700 (PDT)
Date:   Wed, 7 Apr 2021 09:11:18 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/49] *** SUBJECT HERE ***
Message-ID: <20210407071117.GA1354@agape.jhs>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 11:35:54PM -0700, Pavle Rohalj wrote:
> Changes in v2:
>     - Removed type information from variable names
>     - Broken up the changes into smaller patches

Hi Pavle,

I think you missed the subject in cover letter, but maybe
is not a relevant issue...
