Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126E730EE99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhBDIjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:39:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234513AbhBDIjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:39:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6631664F3F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612427948;
        bh=7T4ooX3gO2ANuzbsm/7bQYteNtaVMBp7n3/bStX1vfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kzhP/xClZYYb/hL46TTFDoatKfUtCNakI3R4UKOpYtXIcTj9840J4DpoEsBe+30Px
         zVOqyZGWUkgdNOljGoSQIEBcC1TinR+9k0vl/wRtJXuzn8x6vAe0EwCqQmn5JdC2cv
         1eCyyHdYPu2RtebVsyUr4jt5Qn1bysIhHjMN7q1Tcxnhd6Z5Ja1TqPg2z3+uv+vlX7
         +eA4v8y3PFJMSituWP0V0dbW+zpyj4M4FNiS/qoj+vqa6vbOt6iq7u5rCxJIYdromj
         iEzl50J+8MUSt1cRCoBhMXjWzF2kwZaa3Z5TI+VBy76L0AAtpkYStIcSUohnLA4u7c
         XhryDjyGiDwkA==
Received: by mail-oo1-f53.google.com with SMTP id 123so557639ooi.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:39:08 -0800 (PST)
X-Gm-Message-State: AOAM531FlB0LwJIaimMU9OwT2RdC7aQWUVGC64YDRLk+OqJS/mFQ8/fP
        y53B0V5LmFoekpT0e5JeUJywoVH5k1Cd/kqdH3E=
X-Google-Smtp-Source: ABdhPJxIJXsIuLwOF/19Ymmyrio4uCCCufivYBJTt04GvqJtDM9bh5EnffAXCUYHqq8n7baUTvvUIpIs9xNhWlqsq0I=
X-Received: by 2002:a4a:bb01:: with SMTP id f1mr5046623oop.66.1612427947782;
 Thu, 04 Feb 2021 00:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20210203223826.21674-1-scott.branden@broadcom.com> <ac337905-9bf0-32c6-f98c-5912de1d6655@infradead.org>
In-Reply-To: <ac337905-9bf0-32c6-f98c-5912de1d6655@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 4 Feb 2021 09:38:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1RUBqrhVX5Fv3k41OTryJ1Z8sSD6GM5NqUEYgBy=7jLw@mail.gmail.com>
Message-ID: <CAK8P3a1RUBqrhVX5Fv3k41OTryJ1Z8sSD6GM5NqUEYgBy=7jLw@mail.gmail.com>
Subject: Re: [PATCH v4] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 12:18 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/3/21 2:38 PM, Scott Branden wrote:
> > Correct compile issue if CONFIG_TTY is not set by
> > only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Passes my randconfig builds as well and looks reasonable

Acked-by: Arnd Bergmann <arnd@arndb.de>
