Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F7344D2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhKKH6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhKKH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636617326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAS67uFt9lphof4UNyjuKlZT8zI6/RcA61GqWBR4vRI=;
        b=NnGET7XkY302McTVqyf1Fmsk3tPt7OeLaRhxypARiHabZJLZj6Bv5ZR3+3RwsIwtBO41rA
        jS5olWSHLXFf9n4syqGoomC9AmNspkRMDvs//OoaOaNnQoTCJzIhnP9bgRDlGgu0uE1EHF
        2Mvpd3/vN0QMAnd1P6sE02l4JbOBG80=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-E630AJpQOTapGTbQrE6rjQ-1; Thu, 11 Nov 2021 02:55:25 -0500
X-MC-Unique: E630AJpQOTapGTbQrE6rjQ-1
Received: by mail-ot1-f70.google.com with SMTP id y19-20020a0568301d9300b0056396063834so2835013oti.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zAS67uFt9lphof4UNyjuKlZT8zI6/RcA61GqWBR4vRI=;
        b=na/uekrdXWAkeW2g00wczQ5NuIZBvuVMBhPfXjDioebCZEnppl0/uMtDfi2oMuSZUi
         YigGaZQi4NjwhnkSSPqyFxv9gpSNh5S/wHEev99xFKlLSeUQ28XmeOVws7iDHDpsqC2f
         bYV30IMrBqOWCrP+BpDQ1sluqk/mRcNiKuGDE3m4UIxWdeC4vn62HRhIG0f5aaf6a2rF
         repyJbYE4bkiiV7Pj1VU9naZGQ1deLbEFz0Zv3k7bJKrsLLkgvPXwOKUu2Rn18IZcYrZ
         f0Q1sGx8WGQnR4yYV1DlTCEJQ7TclgWbVB4tTdejlQHfFZ3+dmLE4XhHJKZbbEplrpnU
         jmWg==
X-Gm-Message-State: AOAM530aEubabPuLeG5aqnb9l3ENNRdoOvSavRFa7iXxCpqt4zSLiENv
        HHoAc4BseW7LkYU37c0tYjBbAkIxCODjK2M6W422JkNpEWdRpXlNOYZYMI75mOSovrLudysQEAR
        N+1LwLU0pLmqjiGyM8shUq75e
X-Received: by 2002:a9d:d02:: with SMTP id 2mr4396874oti.358.1636617324802;
        Wed, 10 Nov 2021 23:55:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEerITJxrJ6Bq8yaiUyXjvT7AldZo8pyD4rWdlF2ChnvrC3db1k9jpxicmo0L6SJ0dmYsovQ==
X-Received: by 2002:a9d:d02:: with SMTP id 2mr4396852oti.358.1636617324611;
        Wed, 10 Nov 2021 23:55:24 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id r184sm514328oia.38.2021.11.10.23.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 23:55:24 -0800 (PST)
Date:   Wed, 10 Nov 2021 23:55:21 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH v2 00/23] x86: Remove anonymous out-of-line fixups
Message-ID: <20211111075521.k3iilejdk7ctujmt@treble>
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110100102.250793167@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:01:02AM +0100, Peter Zijlstra wrote:
> Changes since v1:
> 
>  - Dropped using __cold on labels, because clang. Also gcc doesn't actually
>    generate different code with it. The intent was for the code to end up in
>    .text.cold but that doesn't happen.
>  - Fixed the vmread constraints to disallow %0 == %1.
>  - Added a asm-goto-output variant to vmx's vmread implementation.
>  - Audited Xen and FPU code and converted them from -1 to -EFAULT,
>    as a concequence EX_TYPE_NEG_REG no longer exists.
>  - Fixed the EX_DATA_*_MASK macros to include an explicit 'int' cast,
>    such that FIELD_GET() will sign-extend the top field.

I didn't (yet) get the chance to properly review the alignment math in
patches 20 & 21.  Otherwise it looks great to me.

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

