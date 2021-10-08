Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26039426AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbhJHMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:39:33 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbhJHMjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:39:25 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1q8m-1mb0z30PJA-002Dwu for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021
 14:37:29 +0200
Received: by mail-wr1-f48.google.com with SMTP id t8so29583115wri.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 05:37:29 -0700 (PDT)
X-Gm-Message-State: AOAM531RbiDGJuvQVvVdmNomEeLTsYWTdHZNBIXUap7l1KfH5kCkvO5K
        LXtkRTHZsHueCObHVjnlDXRMSseTcp+u87LBsJ0=
X-Google-Smtp-Source: ABdhPJz+OsHH9TxIx5K6iJ9DpkOYbAe4pbkJ+fTL9DRFiVKeKmwkbM0kl6Mrn8Ssl6rKFyFAWgZsHKiq0l0TwmsxawQ=
X-Received: by 2002:a7b:c8d1:: with SMTP id f17mr3224956wml.35.1633696648763;
 Fri, 08 Oct 2021 05:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <s5hpmsh9kdx.wl-tiwai@suse.de> <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
 <s5hee8x9f92.wl-tiwai@suse.de> <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
 <s5hy27497eo.wl-tiwai@suse.de> <20211007160634.GB7074@brightrain.aerifal.cx>
 <s5hr1cw95ar.wl-tiwai@suse.de> <20211007165158.GC7074@brightrain.aerifal.cx>
 <s5h5yu79aab.wl-tiwai@suse.de> <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <20211008120609.GE7074@brightrain.aerifal.cx>
In-Reply-To: <20211008120609.GE7074@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Oct 2021 14:37:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2=X5tPppmcV4x9=pyodiPfoq=tA5jVKuMwA1nKJe=_bA@mail.gmail.com>
Message-ID: <CAK8P3a2=X5tPppmcV4x9=pyodiPfoq=tA5jVKuMwA1nKJe=_bA@mail.gmail.com>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
To:     musl@lists.openwall.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Forney <mforney@mforney.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dRJabWryZJ013H9Z0Vz5AgeK/M7GHGFXvXBXAbOi9piVLZ4VQvE
 mOvCZc05/kjnM3PtBoZ8WuQNnjlo38w251gy8slJqeMUC3aOsyU6WPDwerxuSADD26aPKof
 mm/SuWc6RwsUiHqIYAngBtZ6npIp4YvENmUAQoBJFd8y+QpCypvtill/lXuQ1Rzufw8e30C
 3TgP5kRtYFHoW5yISHf3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f1TPptLP3Zs=:BVdjBpMRpZYw/Y7cs5VZlg
 9CmLHl/uksuYmNTwVgo4QvGM1z5FKcDiQYnOanKNWrPIoQ2Pow/6RvrU6neWEtE/UNuH1lCHw
 bAVyHgyxT5nuQTjpDwdK9HJOrNWYCEcLmfNvk913dPidF/rtlWBDP8qhpnB+MfULE7ERXC9gz
 gCCUXuUfwAP8GxDiKMRlnuTz+YY/u/7zJAOp1UTuuNVOr8RYuz5ZFroAxM+QSouvw6eCNrvcj
 qwn1qcXb7FLTNTu/krhXOkfHrAQ93FEoeS/BbvdcrladeagTcCSJgdUx+g/TNskjASu/dBK1v
 IHaXMybFUaP7qxLH0l7c8/qQU7CUF/WRACO1rFuYEqaovgZGuIf17ZkLPBGUjr5aqFgJOZIfJ
 IiymKtDE61a483brv21CxJDPZWKYrTBpw3t9rjmyJkm4eoa4InqMuyQUCOqsr7EndVAEfNXEK
 P2FWssny84IcTlxu16uXlmJzvnnp1HfNpqqnpyInav20jmRKWjZ4MfNN8aGdFHIfrv8xEsnZx
 kiAFvSduKfNeBtEdkVnC4okToLg3/OgM0ptrwrnet3EpUe7HHZhL4/iOD19VQaOx+ha9FkAlu
 RGH6Bcx2TLC2bESfkslKvT1MKTZ0y0FpY89VFs/e2CoVHMj1o2PAZpH1jzw9MJyRiwAFEo0AW
 D+w9nQK/OwQPmG3QnO4BPnk94GhINW5Q4Pgjn60HOrZ6Lj8IcMWliDAp/M/YKzMzh7vASiIQD
 lZX9in6OLb1oyPybIckzrtdaqNnshSTiuhl3mD169XjgGfusIGGoDF9GOZJHeM5oIzIfI8jdQ
 6mOLvSxMpgdDbPLcwe+JtM74HjUka4spYQfuilK5wlqKovNJ+X2HWXjACALQS9d47OC8TXWi2
 UXcu2sbN0eWQ5+urBqzg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 2:06 PM Rich Felker <dalias@libc.org> wrote:
> On Fri, Oct 08, 2021 at 11:24:39AM +0200, Arnd Bergmann wrote:
> >
> > I've tried to understand this part of musl's convert_ioctl_struct(), but I just
> > can't figure out whether it does the conversion based the on the layout that
> > is currently used in the kernel, or based on the layout we should have been
> > using, and would use with the above fix. Rich, can you help me here?
>
> If the attempted 64-bit ioctl is missing (ENOTTY), it does the
> conversion to the legacy 32-bit one and retries with that, then
> converts the results back to the 64-bit form.

I understand that it tries to do that.

The part that I'm not sure about is which of the two possible
64-bit forms it's using -- the broken one we have defined in the
kernel headers, or the one we were trying to define but failed.

      Arnd
