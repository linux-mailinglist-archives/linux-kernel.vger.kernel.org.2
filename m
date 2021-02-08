Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9355B314450
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBHXwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhBHXwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:52:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7CBC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 15:51:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m22so25587279lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 15:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1ksRfHxQP91F2cobjQCnH7KkqQZ/RBpiypTVeBwL0o=;
        b=Lt1l31FFOyW86MHPhM2dmlp3CnNjnRF35I7kJCzBdAjfBXZt2aOd17ubGFSh/9snq2
         Em/eRjrj32oV9PC5MCVddOkJfTYb8UwvO1fjDEMIzusRgmdyIG3wRdcTHKIMnK58Jqrj
         aPuSUzx/WBihzdrU/9pN3jImIs2zrz6dEfE/OBy1xlGsZamicn/FI8GdJ9e7AEUHsI1w
         WlgQJylgHnEQUorRg5HM00epDUZpSE5mDoBp+TWgcQYket2uTBNCIqs9wTDsofITgRTW
         6pSsP0XVm86nN+0iqMnkXlGb+BdU8QVzzR2JQ18uLADxnMszu8VvhvH4LeOpQcTMZZU3
         JMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1ksRfHxQP91F2cobjQCnH7KkqQZ/RBpiypTVeBwL0o=;
        b=QLO9aVNYzoUo1LBEkZo0oo1nIPyJDbHiIQKSdOxw3AFFxHEBUT8sj0QluQjUGbqiub
         Mrq7nicv1B8ln4ECG+jv2uWNZyT625Kp/CoVxqF+ieYqG7SsOIFzPDn04kQgD7kI9xN2
         PDcx3gkYaDR5oyaVzNvXs1C3WS8y1xcey2yugKI2VQ2vtkBPAFJEpbFUbulAJZy5Ka7J
         mg8sgo+jmz9CruJCCuqeIFWUU3yJLdWpN6hZ2N/1MlJ7KsmgCVdEqYijjSepzZiJK+gx
         p4SCHGGd6NOk5DyidB7phTG0Ih6HWdc4iavkrQOvMd/8jVL3q4LVVqBqnYkNfmXrocTa
         jiSg==
X-Gm-Message-State: AOAM530pGpOSjjZNK/ThB1rwzA91bzAGWyqeR/gzqRv8+dt1CKGKlI7g
        FMSafVmaMmzt16YPr9veVvnpcVNkqe/1iFA0RjZWMg==
X-Google-Smtp-Source: ABdhPJwMzLsIQHn0nFSXjP8TcUTQ0TXQ8EQhTsBbFxlwIDjytkG5rhfFU2ED/MBCcaL0uN6XwAIvfDNm9L0PApMvbHg=
X-Received: by 2002:a19:ca14:: with SMTP id a20mr6347761lfg.567.1612828291075;
 Mon, 08 Feb 2021 15:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20210129030514.1231773-1-john.stultz@linaro.org> <27bd6340-617a-37a2-d17f-8e50b5d5362f@linuxfoundation.org>
In-Reply-To: <27bd6340-617a-37a2-d17f-8e50b5d5362f@linuxfoundation.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 8 Feb 2021 15:51:17 -0800
Message-ID: <CALAqxLWR0h+qzJeRVWe4gpDre7u=Kg7mgnxTv524xXEviZhZdg@mail.gmail.com>
Subject: Re: [PATCH 1/5] kselftests: dmabuf-heaps: Fix Makefile's inclusion of
 the kernel's usr/include dir
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Laura Abbott <labbott@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 3:23 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> On 1/28/21 8:05 PM, John Stultz wrote:
> Thanks John for all these 5 fix and cleanup patches.
>
> Applied to linux-kselftest next for 5.12-rc1
>

Great! I was just prepping to resend them :)
Thanks so much!
-john
