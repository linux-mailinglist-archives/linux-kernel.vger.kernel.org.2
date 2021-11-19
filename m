Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64A745734A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhKSQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhKSQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:45:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E3C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:42:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so9248913pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6usG8MiQSxUWW8t4LIS6CwwnjV4gadMypuBMhJfOTXg=;
        b=SJ/5hd7oOStu335XYv6nQAV6FVZqLIf9hAnFjiCDZVNARjObPclqPpfkPEbcoEKEcw
         UL7tgGQ7+lX1lEDpzzXPu1KfbxDez6M63n1J7dtwKmWViDnGvVnQc++e3Ymsvm2kDgpJ
         Vk6m5PtLG9oteHM0/wRxT6/CxDWmhUxiO3Bjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6usG8MiQSxUWW8t4LIS6CwwnjV4gadMypuBMhJfOTXg=;
        b=Oc19fIcx1yuD2Hh4D4oWv9b4gpmb9x7rtGZAvk/0OTWyhuwAUZd9YwdX6CfSIPdQ5X
         e1R9UMz8tHkp9FYYg4ef0twJb7SCebIMNzY7oqQFFRTY/zhhfiREwHRFpjlnnMpkgQ/E
         lns7MyIpt9dQ+JtSaidOwLiOIBQx+TEXi/JkAF3GS4uznOGSrXIVbpJnHdQ0pPOQ1Kd4
         G3e6SCMhlVTUTu/1/boNJOsO0D5BG0N3B4WV6MuLAVJejA2a897o2SZfvpH7sRy+M05o
         19R8utedz/2Go4ZQddB1F2xY8Mvbt9Wa4MqTn+Q8wozQUlyrtE7OmxNE+Z8N9TjiBpNs
         nxrw==
X-Gm-Message-State: AOAM5309Gahfd1mlOSgZKEmQ7nZEDibRgaNfkUh46SV8Hu2JI4rnVR/M
        FNzOmH7c8M2AGJy3D7HnGXq7Xw==
X-Google-Smtp-Source: ABdhPJxJ0yfws7sNNKBoF+QxKvxIZXPDJEJBvkkmJPuM3LXNvCkaPrbM3z7R/EkI+PBoP+BKqrRXXA==
X-Received: by 2002:a17:902:cb8a:b0:141:f601:d5f1 with SMTP id d10-20020a170902cb8a00b00141f601d5f1mr79797842ply.77.1637340131104;
        Fri, 19 Nov 2021 08:42:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm11083635pjo.44.2021.11.19.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:42:10 -0800 (PST)
Date:   Fri, 19 Nov 2021 08:42:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
Message-ID: <202111190839.B6EC699B1@keescook>
References: <20211118203604.1288379-1-keescook@chromium.org>
 <1e312cbd-cd52-ddce-f839-db765173c526@csgroup.eu>
 <202111190824.AEBBE1328@keescook>
 <7f4e7d24-6eb0-5ecf-3497-61c3633046bd@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f4e7d24-6eb0-5ecf-3497-61c3633046bd@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 05:35:00PM +0100, Christophe Leroy wrote:
> Neither do I. I was just scared by what I saw while reviewing your patch. A
> cleanup is probably required but it can be another patch.

Heh, understood! For my end, my objective with the fortify work is to
either split cross-member memcpy() calls (which is usually undesirable) or
add a struct group so it can be seen as a "single member" memcpy again
(and usually results in 0 differences in binary output). :)

-- 
Kees Cook
