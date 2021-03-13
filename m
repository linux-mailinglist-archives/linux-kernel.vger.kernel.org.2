Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C38339AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 02:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhCMBz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 20:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhCMBze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 20:55:34 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A28C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 17:55:33 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id f2so9469274pjt.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SmCiaIj4fa/BntGmklruqMNsz/t3oXGt1XKruu0aMRA=;
        b=B98B11Im5itjp0Kmsnv8x0PVZohh9t3Z+Qe0bEFacNwdVrdELuVlSdcNMc6SnG74QE
         xw5Jga0rtYomYVcIlMYdvVRpSwMW4LAsrezoJ1iUibR9i0F/tJdXw4F/ehpZZrA62104
         OSz8CzWA9rF2PkIjws1SrwHDPL6pVixtmKzIdHWuYVODTvLjsHfU9XN/9Zda34G0vab+
         ktO89BYEoD10KSA3DnUzmNQ/9PgKtcIkWIXR3iAw8iCZDzcOBXUD6opd9rGVkdvFv+wX
         gB064quQ9EUR0Cx/kZFEeHEQrlwM7MkC8Izc7zr+yoWeb5sZGFAq20WExNoZCm9LvecH
         kLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SmCiaIj4fa/BntGmklruqMNsz/t3oXGt1XKruu0aMRA=;
        b=JXze3amq/lRXmXNi4zM3tRx9dyl+MhRNZCOAXBeTNY4saCa8Hnb3zYzHW5buD5v3nl
         AnXjnXMlI7XEzOCo9ztn01WM9dn/vLYsDc/4BL/Z9+ZmOMYVwJIf1sGjom7QQAMF6MmJ
         2IBamE9zpf2IAxQSF671SfxHEuz07VdZXXvfWehtYaOGhKV9ex/EPqzXw8nEbBYW2sD0
         i3v/zen9S/CjRZgjxCCepNvVp0lGEb6zKYOWM4+VC0ljVF0PZ+4kJbfnYhwcezORrjd+
         qEV9YrvEYwHVjPYlfbFdutSpjGf1WMnMYmMcypUcBC9I5/pY+Q49vdCiR/W8Rghsi+bh
         K89A==
X-Gm-Message-State: AOAM532mAaE3vhDbNKZzK/1o/tcMtlWBtuXUiPj3GkKde4jFrJ2RV0fo
        h6w1Wy9veE54oeQ5Wucd+XWGYLf0
X-Google-Smtp-Source: ABdhPJwhh25oOc/8AJVs7FL5eGzsu8RlANUl9BwX2RMIN7WSJXFoNJtiRI++7NwAsSX0QjlN4YWHtAqg
X-Received: from juew-desktop.sea.corp.google.com ([2620:15c:100:202:91c2:423c:5356:a5c6])
 (user=juew job=sendgmr) by 2002:a05:6a00:15d4:b029:1fb:17bf:abe5 with SMTP id
 o20-20020a056a0015d4b02901fb17bfabe5mr971565pfu.39.1615600533243; Fri, 12 Mar
 2021 17:55:33 -0800 (PST)
Date:   Fri, 12 Mar 2021 17:55:31 -0800
In-Reply-To: <20210309200140.GA237657@agluck-desk2.amr.corp.intel.com>
Message-Id: <20210313015531.1737679-1-juew@google.com>
Mime-Version: 1.0
References: <20210309200140.GA237657@agluck-desk2.amr.corp.intel.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: Re: [PATCH v2] mm,hwpoison: return -EBUSY when page already poisoned
From:   Jue Wang <juew@google.com>
To:     tony.luck@intel.com
Cc:     akpm@linux-foundation.org, bp@alien8.de, david@redhat.com,
        hpa@zytor.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        naoya.horiguchi@nec.com, osalvador@suse.de, tglx@linutronix.de,
        x86@kernel.org, yangfeng1@kingsoft.com, yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe the mutex type patch has its own value in protecting 
memory_failure from other inherent races, e.g., races around 
split_huge_page where concurrent MCE happens to different 4k pages 
under the same THP.[1] This realistically can happen given the physical
locality clustering effect of memory errors.

Thanks,
-Jue

[1] The split fails due to a page reference taken by other concurrent 
calling into memory_failure on the same THP.

