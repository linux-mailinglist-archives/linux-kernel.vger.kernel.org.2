Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670523B5D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhF1Le5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhF1Ley (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:34:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2455C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:32:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g198so3256424wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UrSJbYhtxBx2FTQdiX41ACJV4Ep9W6b260mBsZuUNNM=;
        b=nmD/Uuhp0g39lnpRh10SJyeL1R/mJXyES82cLCgAc4unfhoKEQStptFHWZipVWFtkF
         4z1aJERywbVSJQWNb4iz9CPVAc2i2JSJg6Eb1nsVVAVPXTuFl77WtHyGWjNmME/nu8EW
         lM+tMNPCIn0bnOAQJg2P2pThZV7iVcVtOgqEpMOeHn2BS9H4n9bB69Anfz6o0twP0oHo
         OriDj6kidg75JT4MBt1+ZW7PDhAzVYg1/6sEDdO6xJOGQUry2k1Me2lRp+erwon8pir5
         xoGr2hvYq5sgty3kRSAX/hr/mVnSwvuceQjQZ5qelCIfsvsJfH8bg8yRDxuNo00Io2wH
         cNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UrSJbYhtxBx2FTQdiX41ACJV4Ep9W6b260mBsZuUNNM=;
        b=NYqSNd0IGaTAhxWzPrQVhwAabK9ZAacMbCxngC0mZAQzhkqkWL4fLSvyrwi9NmnmLk
         nsa+VZKvUF6cuLUgdcnvQhgxbr14z0sBy5RaRsSuTZKqmNPZpp/JW6G8L4zFFwkOVdii
         MT5B3H9SfaKq43/4weJWrd/XSzDf3C6CuDyvRsLx7xK4P2hczhMivFMBUe8vBLWwgqDH
         FjdzDPZaIJ0heAWk2SMGoWA36CW4Vhnt7xORCQvCfJ6zffYq4P7Od467J9ffIR7Rqo3p
         9HYt6TUrkL2D6ZrAPiB4UpZZtfrLuz63xCdKLb+Qi+305/TAettwePMMuBhLZnF73RC+
         fn8g==
X-Gm-Message-State: AOAM530uZB9PR7r/7CvSgA/yW4pQ8FmsP55bZuIF+dhl9pLvgZ5/24kt
        PETSNg//OvnfF38wtRGHxW9/uI19eWA=
X-Google-Smtp-Source: ABdhPJzmNU6ZWxxLWVpODyQZq9EyI+1VvIoxWutMCJKeDOQkjc+/7jRg1j1Y9zX8aEaT3l4JPFJWNA==
X-Received: by 2002:a7b:c395:: with SMTP id s21mr25674124wmj.164.1624879946108;
        Mon, 28 Jun 2021 04:32:26 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id f9sm800659wrm.48.2021.06.28.04.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 04:32:25 -0700 (PDT)
Subject: Re: [RFC] strcpys(): New function for copying strings safely
To:     David Laight <David.Laight@ACULAB.COM>,
        glibc <libc-alpha@sourceware.org>
Cc:     "tech@openbsd.org" <tech@openbsd.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        drepper@gmail.com
References: <755875ec-baae-6cab-52a8-3c9530db1ce6@gmail.com>
 <38428d5e-ead2-bf18-e198-cecd4caeb3e7@gmail.com>
 <f5bfab0dce604736b6a563a4f9f7ce43@AcuMS.aculab.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <52e57bd5-0d04-4b4f-978a-8c1dbc08115c@gmail.com>
Date:   Mon, 28 Jun 2021 13:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f5bfab0dce604736b6a563a4f9f7ce43@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On 6/28/21 10:15 AM, David Laight wrote:
> From: Alejandro Colomar
>> Sent: 27 June 2021 20:47
>>
>> On 6/27/21 9:26 PM, Alejandro Colomar (man-pages) wrote:
>>>
>>> It is designed so that usage requires the minimum number of lines of
>>> code for complete usage (including error handling checks):
>>>
>>> [[
>>> // When we already checked that 'size' is >= 1
>>> // and truncation is not an issue:
>>>
>>> strcpys_np(size, dest, src, NULL);
>>
>> Also, given how unlikely this case is, I have in my code:
>> `[[gnu::warn_unused_result]]`
> 
> warn_unused_result is such a PITA it should never have been invented.
> At least no one seems to have been stupid enough to apply it to fprintf()
> (you need to do fflush() before looking for errors).

Okay.  After some thought, I think removing it is better.

> 
> In most cases strcpy() is safe - but if the inputs are 'corrupt'
> horrid things happen - so you need truncation for safety.
> But you really may not care whether the data got truncated.

Yes, in most cases, expecially with literal strings ("xxx") and known 
buffers, strcpy() is completely safe.

And yes, if the input is untrusted (may be corrupt or not), you need to 
be prepared for truncation.  You don't need to truncate, hey, maybe the 
input is well-formed, but you need a function that may truncate if needed.

For that, we have strncpy(3), strlcpy(3bsd), and strscpy (kernel).

strncpy(3) is not for strings; it is for fixed length buffers.  It has 
high performance penalties, and yet doesn't guarantee a C-string. 
DISCARDED.

strlcpy(3bsd) still requires that the input is a C-string, so it can't 
be used with untrusted strings.  It really is broken, as Linus said. 
Its only valid use is if the input string is known (maybe a literal), 
but the output buffer may be smaller than the input string.  DISCARDED.

strscpy (kernel) is great.  BUT it is not supported by glibc.  The 
reason for not including it (actually Ulrich used it for not including 
strlcpy, but it also applies to strscpy) is that it doesn't report an 
error when the string is truncated.  I think that strscpy adds value to 
the current strcpy variants, and should be added to glibc.

And then, coming back to truncation, yes, in some cases, truncation is 
wanted, and not an error, for which strscpy is great (so please add it 
to glibc :), but then there are other cases where truncation is not 
wanted, but yet we deal with untrusted strings.  That is the case that I 
think Ulrich mentioned that wasn't covered by strlcpy (and isn't yet 
covered by strscpy).  And the reason to add this function.

Let's say a user introduces a username;  it's an untrusted string, we 
need to process it at least with strscpy().  But if it is corrupted (too 
long), we don't want to silently store a truncated username; we want to 
inform the user, so that he introduces a new (hopefully valid) username. 
  For that, strcpys() as defined in the previous email, is necessary.

> 
> The other use is where you want a sequence of:
> 	len *= str_copy(dest + len, dest_len - len, src);
> But don't really want to test for overflow after each call.

This is a legitimate use of strscpy().  Please, add it to glibc, as 
there is no libc function to do that.

> 
> In this case returning the buffer length (including the added
> '\0' on truncation works quite nicely.
> No chance of writing outside the buffer, safe truncation and
> a simple 'len == dest_len' check for overflow.
> 
> OTOH there are already too many string copy functions.

There are, but because the standard ones don't serve all purposes 
correctly, so people need to develop their own.  If libc provided the 
necessary functions, less custom string copy functions would be 
necessary, as Christoph said a long time ago, which is a good thing.

As I see it, there are the following, each of which has its valid usage:

strcpy(3):
	known input && known buffer
strncpy(3):
	not for C strings; only for fixed width buffers of characters!
strlcpy)3bsd):
	known input && unknown buffer
	Given that performance-wise it's similar to strscpy(),
	it should probably always be replaced by strscpy().
strscpy():
	unknown input && truncation is silently ignored
	Except for performance-critical applications,
	this call may replace strcpy(3), to add some extra safety.
strcpys():
	unknown input && truncation may be an error (or not).
	This call can replace strscpy() in most cases,
	simplifying usage.
	The only case I can see that strscpy() is superior
	is for chains of strscpy(), where I'd only use strcpys()
	in the last one (if any strscpy() in the chain has been
	trunncated, so will the last strcpys() (unless it's "")).


For the reasons above, I propose both strscpy() and strcpys() for 
inclusion in glibc.  Both trivial sources are in the previous email.

Thanks,

Alex


---

BTW, I did some research in the kernel and glibc sources to see how are 
str*cpy functions being used there:


user@sqli:~/src/gnu/glibc$ grep -rn 'strcpy(' * | sort -R | head -n 7
string/tester.c:1126:  (void) strcpy(one, "abcd");
resolv/nss_dns/dns-host.c:532:      strcpy(qp, "ip6.arpa");
dirent/tst-fdopendir.c:70:  strcpy(fname, "/tmp/dXXXXXX");
string/tester.c:1006:  cp = strcpy(one, "abc");
timezone/zic.c:459:  return result ? strcpy(result, str) : result;
timezone/zic.c:2886:					strcpy(startbuf, zp->z_format);
resolv/compat-gethnamaddr.c:393:			strcpy(bp, qname);



- string/tester.c:1126:  (void) strcpy(one, "abcd");
Okay.

- resolv/nss_dns/dns-host.c:532:      strcpy(qp, "ip6.arpa");
Okay.

- dirent/tst-fdopendir.c:70:  strcpy(fname, "/tmp/dXXXXXX");
Okay.

- string/tester.c:1006:  cp = strcpy(one, "abc");
Okay.

- timezone/zic.c:459:  return result ? strcpy(result, str) : result;
Okay.

- timezone/zic.c:2886:					strcpy(startbuf, zp->z_format);
I couldn't find a guarantee that zp->z_format is NUL-terminated.
Possible buffer overrun.
I couldn't find a guarantee that zp->z_format fits in startbuf.
Possible buffer overflow.
This call could be replaced, at least, by strlcpy.  The calls to strchr()
previous to that strcpy() may also benefit from using strnchr().

- resolv/compat-gethnamaddr.c:393:			strcpy(bp, qname);
Okay.

user@sqli:~/src/linux/linux$ grep -rn 'strcpy(' * | sort -R | head -n 3
drivers/platform/x86/wmi.c:346:	strcpy(method, "WQ");
sound/pci/atiixp.c:1305:		strcpy(pcm->name, "ATI IXP IEC958 (AC97)");
sound/pci/intel8x0.c:1439:		strcpy(name, "Intel ICH");

user@sqli:~/src/linux/linux$ grep -rn 'strlcpy(' * | sort -R | head -n 3
tools/perf/builtin-buildid-cache.c:124:	strlcpy(from_dir, filename, 
sizeof(from_dir));
drivers/usb/gadget/function/u_ether.c:148:	strlcpy(p->version, 
UETH__VERSION, sizeof(p->version));
drivers/scsi/qla4xxx/ql4_mbx.c:1615:	strlcpy(username, chap_table->name, 
QL4_CHAP_MAX_NAME_LEN);

user@sqli:~/src/linux/linux$ grep -rn 'strscpy(' * | sort -R | head -n 3
sound/core/pcm.c:732:		strscpy(pcm->id, id, sizeof(pcm->id));
sound/usb/hiface/pcm.c:597:	strscpy(pcm->name, "USB-SPDIF Audio", 
sizeof(pcm->name));
crypto/crypto_user_stat.c:54:	strscpy(rcipher.type, "cipher", 
sizeof(rcipher.type));




- drivers/platform/x86/wmi.c:346:	strcpy(method, "WQ");
Okay

- sound/pci/atiixp.c:1305:		strcpy(pcm->name, "ATI IXP IEC958 (AC97)");
Okay

- sound/pci/intel8x0.c:1439:		strcpy(name, "Intel ICH");
Okay
The sprintf() 2 lines above is also okay.


- tools/perf/builtin-buildid-cache.c:124:	strlcpy(from_dir, filename, 
sizeof(from_dir));
Okay.  BUT no libc support!

- drivers/usb/gadget/function/u_ether.c:148:	strlcpy(p->version, 
UETH__VERSION, sizeof(p->version));
Okay.  BUT no libc support!
However, in the next line, it's not obvious where dev->gadget->name 
comes from.
eth_get_drvinfo() is a callback (it's stored in a pointer), so I can't 
follow it.
If it were an untrusted string (not NUL-terminated), it would be a bug.

- drivers/scsi/qla4xxx/ql4_mbx.c:1615:	strlcpy(username, 
chap_table->name, QL4_CHAP_MAX_NAME_LEN);
Okay.  BUT no libc support!


- sound/core/pcm.c:732:		strscpy(pcm->id, id, sizeof(pcm->id));
Okay.  BUT no libc support!

- sound/usb/hiface/pcm.c:597:	strscpy(pcm->name, "USB-SPDIF Audio", 
sizeof(pcm->name));
Okay.  BUT no libc support!

- crypto/crypto_user_stat.c:54:	strscpy(rcipher.type, "cipher", 
sizeof(rcipher.type));
Okay.  BUT no libc support!


None of the above checked for truncation, so I assume it's not an issue 
there.



-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
