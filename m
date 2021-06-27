Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C473B5501
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 21:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhF0T3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 15:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhF0T3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 15:29:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF484C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 12:26:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so12106105wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HCKUdWXvGhg+djwTyUkQ9Pote1w8va7vU1xMZBIS6OI=;
        b=gA+xzWKi5rjsQHCtVMyGSq1UY4unywjsNDNnPy04G2SLKG+1KNfOYGxZVM9nI7V0Jg
         3fGExO4my6g0Dwud+iOMHIPM8kvPRllkXakKcug72mwCJhnozCNKdVPd+pmjJtttNbns
         NtidWcsBxky00JcXLW7nMjS6mVQGzB6wSKONjrHLQj7qbU2k9mkhQeY6HHoorgQVByeL
         JthkoW5OyOwGLELMicuXNOX8guzrgaGILRf3ujeN/HB4Cr6ifYrA/yn+g6458Q5B140g
         nyYFT8SohPyWQzw5TnvGjPjESfJ9rn+RqEmX8ynLOQkxUfuD1EV043K5mycCTLErmgWx
         ok/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HCKUdWXvGhg+djwTyUkQ9Pote1w8va7vU1xMZBIS6OI=;
        b=Em7HRwK3bkPAf9airEoAf/g+2bbhqcJGxdrlTyPaian8ChvL8tVOcShITE6tm5FBhW
         mImtnV7rrbhKshU82OWnjhCTRp0r8wPvnHxtj12zV7UNdxetDQn3zJgh8wiB6lF8+3Kj
         fFMHA5LpRYnXtFy15igvRNzDRKg+aJrr8ozUAt3+fsw8by6bFLEkJ5erEfGHWGllgF8s
         MLZXlhqS9RzdoHTfoxMtN+he02uN3I6k0q78lQASgStG2L3fce79l00yr2ivspWHWVar
         FiJmM385SDrWDYFCHlfifHrQ3Sk2aH9+UexGhNZAHUihm0bsuQiy3aXeo2/a/cql5jCS
         5eIg==
X-Gm-Message-State: AOAM5313IvZgcVXSqa0aUWdEs1nYWOqiVoAQjFUU72xwl1wEbGxk4utv
        ke2H0/NVgyVTTJEH7L0bFOHj2rXnPbk=
X-Google-Smtp-Source: ABdhPJyP95IwRPm5jriUAXLvJ5dCSADyrXgk9RY3jVlV3L+pnkYSs5J2Q9GNlfspQ4WJV0oKp+K8fQ==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr22441383wmc.137.1624821998419;
        Sun, 27 Jun 2021 12:26:38 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id n12sm3951985wrs.12.2021.06.27.12.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 12:26:37 -0700 (PDT)
To:     glibc <libc-alpha@sourceware.org>
Cc:     tech@openbsd.org, Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Subject: [RFC] strcpys(): New function for copying strings safely
Message-ID: <755875ec-baae-6cab-52a8-3c9530db1ce6@gmail.com>
Date:   Sun, 27 Jun 2021 21:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently re-read the discussions about strscpy() and strlcpy().

https://lwn.net/Articles/612244/
https://sourceware.org/legacy-ml/libc-alpha/2000-08/msg00052.html
https://mafford.com/text/the-many-ways-to-copy-a-string-in-c/
https://lkml.org/lkml/2017/7/14/637
https://lwn.net/Articles/659214/

Arguments against strlcpy():

- Inefficiency (compared to memcpy())
- It doesn't report truncation, needing extra checks by the user
- It doesn't prevent overrunning the source string (requires a C-string 
input)

Arguments in favor of strlcpy():

- Avoid code bloat
- Self-documenting code
- Avoid everybody rolling their own strcat() safe variant
- Prevent buffer overflows


I rolled my own strcpy safer functions some time ago, and after reading 
those discussions, I decided to propose them for inclusion in glibc.

I think they address all of the arguments before (well, efficiency will 
never be as good as memcpy(), I guess, but a good compiler, and -flto 
can make it good enough).

It reports two kinds of errors: "hard" errors, where the string is 
invalid, and "soft" errors, where the string is valid but truncated.
The method for reporting the errors is an 'int' return value, which is 0 
for success, -1 for "hard" error, and 1 for "soft" error.

The value of written characters that strcpy() functions typically 
return, is now moved to a pointer parameter (4th parameter).

The order of the parameters has been changed (compared to other strcpy() 
typicall variants), according to a new principle of the C2x standard, 
which says that "the size of an array appears before the array".
<http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2086.htm>

It doesn't require a C string in the input.  It only reads up to the 
size limit provided by the user.

I added the _np suffix to the function to mark it as non-portable 
(similar to existing practice in glibc with non-standard functions).

I used 'ssize_t' instead of 'size_t', because I consider unsigned types 
to be inherently unsafe.  See 
<https://google.github.io/styleguide/cppguide.html#Integer_Types>.

It is designed so that usage requires the minimum number of lines of 
code for complete usage (including error handling checks):

[[
// When we already checked that 'size' is >= 1
// and truncation is not an issue:

strcpys_np(size, dest, src, NULL);

// When we ddidn't check the value of 'size',
// but truncation is still not an issue:

if (strcpys_np(size, dest, src, NULL) == -1)
	goto handle_hard_error;

// When truncation is an issue:

if (strcpys_np(size, dest, src, NULL))
	goto handle_all_errors;

// When truncation is an error,
// but it requires a different handling than a "hard" error:

status = strcpys_np(size, dest, src, NULL);
if (status == 1)
	goto handle_truncation;
if (status)
	goto handle_hard_error;
]]

After any of those samples of code, the string has been copied, and is a 
valid C-string.


Here goes the code (strcpys_np() is defined in terms of strscpy_np(), 
which similar to the known strscpy(), but with some of the improvements 
mentioned above, such as using array parameters, and ssize_t):


[[

#include <string.h>
#include <sys/types.h>


[[gnu::nonnull]]
ssize_t strscpy_np(ssize_t size,
                    char dest[static restrict size],
                    const char src[static restrict size])
{
	ssize_t len;

	if (size <= 0)
		return -1;

	len = strnlen(src, size - 1);
	memcpy(dest, src, len);
	dest[len] = '\0';

	return len;
}

[[gnu::nonnull(2, 3)]]
int strcpys_np(ssize_t size,
                char dest[static restrict size],
                const char src[static restrict size],
                ssize_t *restrict len)
{
	ssize_t l;

	l = strscpy_np(size, dest, src);
	if (len)
		*len = l;

	if (l == -1)
		return -1;
	if (l >= size)
		return 1;
	return 0;
}

]]

I may have introduced some bugs right now, as I adapted the code a bit 
before sending, but I expect it to be free of any bugs known of the 
existing str*cpy() interfaces.


What do you think about this function?  Would you want to add it to glibc?


Thanks,

Alex



--
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
