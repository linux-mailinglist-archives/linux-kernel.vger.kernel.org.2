Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33285352B06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhDBNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:32:05 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:32:03 -0400
Received: from [192.168.1.155] ([95.118.52.208]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfpKZ-1m7xFf3xRx-00gEPf; Fri, 02 Apr 2021 15:31:51 +0200
Subject: Re: [PATCH] platform/x86: intel_pmc_core: export platform
 global_reset via sysfs.
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210401213144.1009224-1-tomas.winkler@intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <f930c11b-7324-19ee-9776-d97a90533b21@metux.net>
Date:   Fri, 2 Apr 2021 15:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210401213144.1009224-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IZu7NSzQEdCaYaop5YZYea5lfTlHFn4m6/du8f79d+chvvJdTbJ
 GoShAPEkxR3vPrar/3Utbf2kjaDOuQIUIqZZXPTdoBoUWwalMwIHmNVXlonzm8RtOhe1BZa
 0+vKpTk1MLoToSWAurd3eeM3iSstaH1SAqthJlK1gZ6GLqK+K6Y7Jew5r+glvWEjpDpGBbr
 6EFIhglDGJ5jPiwJN4LSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+IWMqBpt+/U=:pn+iKmMLb+Mm1y73/k7FgN
 ug+msfUqiHCnXrfGEp24dtGv+Pxi2/IrKt9XI/djlpb1EBakRTXXGJDBZamUh696avsrZrbdu
 wYaQyRb1lGH6JSEM1i926u0OslC/x2iaklAqB1YYZknQ+J9PAwLFwvCxAY7TxQKHNh/En336M
 ug2BfBTSNUMGEGzoLyLwWlWsaPNJ9FO2Bi+nt6yl0UuNU/tcL1EpKV9cDozZJzun9C50DTMmY
 ijXRDubX99HVCaRxT88niu7DPz/VTghcG8voRqxDW2MwvL6T0fPGQiwLIT4QBPEBir9TQA61H
 ALTKeaOobN5mltky0yhFY23tkkljhMoyAmka5DxPTKD0Zb3y9M2URMqKcvvLrwcHkkXnykqKV
 ATBArGE2Wxasbzni5OrPw25yqDlOhM9a5JM05aQHG2X47x62OTVRmFS+NeEh5MiJEGuyEmdAV
 Tmdnn6HvcFS2fZ68I7Eocpfgh5zORhYF37xrO2cda6/CgwoG6HJs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.21 23:31, Tomas Winkler wrote:

Hi,

> During PCH manufacturing a global reset has to be induced in order
> for configuration changes take affect upon following platform reset.
> This setting was commonly done by accessing PMC registers via /dev/mem
> but due to security concern /dev/mem access is much restricted, hence
> the reason for exposing this setting via dedicated sysfs interface.
> To prevent post manufacturing abuse the register is protected
> by hardware locking.

could you please define "manufacturing" ? The chip or board ?

Is there any use for this, after the machine left the factory ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
