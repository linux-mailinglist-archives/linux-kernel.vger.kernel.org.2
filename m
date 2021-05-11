Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8B37A404
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhEKJuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhEKJuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:50:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A19C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:49:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j10so1773157ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YSPQb+nNhnbHjEsR3HVzuPYSWfg6mm9JCNCoWb+AMRM=;
        b=X3g8K0/hKUdTNwUFXwDV4w0mAPHm0EmWP/RkTq825cV95ZXefEGwlmVoQdbTlYXfl8
         C52wdhVHyB7ttOyRrjJpfYTHM2Gi0n+LmT+szHzDWuXeVKOazdD+1Bp7v2JDMwuVoXGw
         ckDichZPITLgyE3V0dLTOhk+uofk8f7iXi5cHGo+Ns8SfvCiasBsNZ2K6FfCf8jiS4Dn
         VjaSmbAcnVnfgV2u1Alkqfm142x/+gPRSYJQ5CM0eSWdIB9nKBhaH9bEzyzHM751AJYV
         9+wUX9j7NQcRGiaVJvViTz0b3pSpCyXStYgonEPPqxnpSgDI8dxWkD+pVLHH6XPGuN3X
         G8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YSPQb+nNhnbHjEsR3HVzuPYSWfg6mm9JCNCoWb+AMRM=;
        b=dnaaPKha+kQ9rybmUOZleeYEAGhYCkzFZq1CMbXAb+Ef+YTu6bYB+g54Sle2NRHgs8
         R2w/DWqIseO6/IFb/i7l9VY1XbYXSAqw5zJSnd4v/lcFzMUOn66KcqdJDg+Yn23KsgXv
         BTDZwOUIAFpmlK9Kqp9NfN4d+YyDi5dLcOSWEUqyapM3VuO2x0RfmOu1tYAjKhUDchtm
         Sbgva6XuIX0FHbrQHQQd3/JG6df0qTQ2BpVwBk+gCwiW3ixNc8sMsg9y+hzwsYBxrjpJ
         TLkKTYb0uJsrAihztCJI4kROtHVgV9H+Gg/M/JJKo/BS8S4Kz3PlR71wadgww+ij/MMP
         fkDg==
X-Gm-Message-State: AOAM5337sQ5Ly6Dw8Tmcfg3gvYbxQ3SOOksycsHhtfLPwSL39my2tS0A
        90qivhQZ7f/gPQ65mrMUWko=
X-Google-Smtp-Source: ABdhPJxZa829+QL5jbwdtz3dPtohmnrtZI1I5h18ymDFnMn/Tnyq3hrwl5A8Ru1/XvIEBxZPjKD69w==
X-Received: by 2002:a17:906:980a:: with SMTP id lm10mr1264055ejb.482.1620726570534;
        Tue, 11 May 2021 02:49:30 -0700 (PDT)
Received: from agape.jhs ([5.171.80.244])
        by smtp.gmail.com with ESMTPSA id p5sm4431070ejm.115.2021.05.11.02.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 02:49:30 -0700 (PDT)
Date:   Tue, 11 May 2021 11:49:27 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] staging: rtl8723bs: replace private CRC-32
 routines with in-kernel ones
Message-ID: <20210511094927.GA1410@agape.jhs>
References: <cover.1620652505.git.fabioaiuto83@gmail.com>
 <cdd9bc521b7119a9c2787b46109eb76f94bd295a.1620652505.git.fabioaiuto83@gmail.com>
 <29938747c82e4cf1837be5f1cdb803b7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29938747c82e4cf1837be5f1cdb803b7@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Mon, May 10, 2021 at 01:38:49PM +0000, David Laight wrote:
> > replace private CRC-32 routines with in-kernel ones.
> 
> Have you verified that they compute the same CRC?
> 
> There are all sorts of subtle reasons why the outputs can differ.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

I tried this:

#include <linux/module.h>
#include <linux/crc32poly.h>
#include <linux/crc32.h>

/* Copy pasted from rtl8723bs/core/rtw_security.c */
static signed int bcrc32initialized;
static u32 crc32_table[256];

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("CRC-32 verifier");
MODULE_AUTHOR("Fabio Aiuto");

/* Copy pasted from rtl8723bs/core/rtw_security.c */
static u8 crc32_reverseBit(u8 data)
{
        return ((u8)((data<<7)&0x80) | 
                ((data<<5)&0x40) | 
                ((data<<3)&0x20) | 
                ((data<<1)&0x10) | 
                ((data>>1)&0x08) | 
                ((data>>3)&0x04) | 
                ((data>>5)&0x02) | 
                ((data>>7)&0x01));
}


/* Copy pasted from rtl8723bs/core/rtw_security.c */
static void crc32_init(void)
{
        if (bcrc32initialized == 1)
                return;
        else {
                signed int i, j;
                u32 c;
                u8 *p = (u8 *)&c, *p1;
                u8 k;

                c = 0x12340000;

                for (i = 0; i < 256; ++i) {
                        k = crc32_reverseBit((u8)i);
                        for (c = ((u32)k) << 24, j = 8; j > 0; --j)
                                c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE : (c << 1);
                        p1 = (u8 *)&crc32_table[i];

                        p1[0] = crc32_reverseBit(p[3]);
                        p1[1] = crc32_reverseBit(p[2]);
                        p1[2] = crc32_reverseBit(p[1]);
                        p1[3] = crc32_reverseBit(p[0]);
                }
                bcrc32initialized = 1;
        }
}

/* Copy pasted from rtl8723bs/core/rtw_security.c */
static __le32 getcrc32(u8 *buf, signed int len)
{
        u8 *p;
        u32  crc;

        if (bcrc32initialized == 0)
                crc32_init();

        crc = 0xffffffff;       /* preload shift register, per CRC-32 spec */

        for (p = buf; len > 0; ++p, --len)
                crc = crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
        return cpu_to_le32(~crc);    /* transmit complement, per CRC-32 spec */
}

static int __init crc32_entry(void)
{
        u8 payload;
        unsigned char crc_priv[4], crc_pub[4];

        payload = (u8)1234;
        /* private crc calculation used in rtl8723bs */
        *((__le32 *)crc_priv) = getcrc32(&payload, 2);
        pr_info("private rtl8723bs crc: %x", *crc_priv);
        /* in-kernel public crc calculation */
        *((__le32 *)crc_pub) = ~crc32_le(~0, &payload, 2);
        pr_info("generic crc: %x", *crc_pub);

        return 0;

}

static void __exit crc32_exit(void)
{
}

module_init(crc32_entry);
module_exit(crc32_exit);

And run it on qemu. Don't know why to display the second pr_info()
I have to rmmod it, but both methods give the same result (62)

[   38.149979] crc32m: module is from the staging directory, the quality is unknown, you have been warned.
[   38.169208] private rtl8723bs crc: 62
[   38.169400] generic crc: 62

thank you,

fabio
