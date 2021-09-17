Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB841001E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhIQT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbhIQT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:59:38 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC422C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:58:15 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id jo30so7190854qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8z3zDqb9jHwewDsR6d6jFjnHJNDXqkGQ9qKSj/mtO3I=;
        b=p3i2eO9bZioHssZ6kaL2EhcmSvQnkzqovV6gtYx5yBvZO8U8YgpWOlQ4NiPfFu4X/J
         kq42DVIAloR+3OGOhdrNAXTsMwGB1U7dJa3O879NkyHssAV9C272KFs31R+STdzezEk4
         iOZgQfQWGyJRlmnpBjLIy+vbAbGLNiJBL5ugeXvgBB2jn2P24RbSi3TeTA5A0lwnn47s
         PwzdY3me6Ws7HWX0K/11ZDJyTAFXZiSXZab+/pD+cz4UkJGM1xapMnr2hW0LlT/rH1Z2
         Pa2ny4IAV+bTWgisTZ1NVj/q+S69AWy3isi9fdKt0PhqH0B6B0mHZsYzenKs+68iYGK4
         PjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8z3zDqb9jHwewDsR6d6jFjnHJNDXqkGQ9qKSj/mtO3I=;
        b=oA1c8GXwCcniTE9mQcnRodwaTSd6Wge/3+HXol3hWQmljdK25DcvGGInTrifYE8MoV
         7otYySZb9HgsNXbFbSdYAkJYnqyyQ3P+oQs0CYx8qNvltlKV8X3t3QHzKYj12ba5IWSJ
         HeMiNIpOArd7QADCldDRKtbU703USiiOtAKdzvyRjPF7ii5kNObgOtS4GLAfLWSQXejo
         R7JfjiOlTiO3PX5RClqHxX6x1PeWwjPae9E7PiabSEflA6aXgOAU5c+VlOclGk+uofyy
         nfI1uMMd1twi2NQh8tnP66RZNWjuuJ5f38A1ncZHLg+CkmzEjEAjrH9n3HoIcGIGtDqE
         cCcw==
X-Gm-Message-State: AOAM530NWmElu3KKB8TaSrehrl8aojLkCjIbEUNOOyibRI9YD8TRP6x8
        G2mD6y0n6utREGWrB3l8lk2KFiqr85tIB4AZkaTaOg==
X-Google-Smtp-Source: ABdhPJysvju3XJK4m5TLIBko5UdMP99X9nPaX+/RaXTnto8yzzNUOgy9Ubt0YChaRdH/XrJYPig/CcByqqM5VGpMwWA=
X-Received: by 2002:ad4:436b:: with SMTP id u11mr12932089qvt.26.1631908694821;
 Fri, 17 Sep 2021 12:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210909140815.2600858-1-yukuai3@huawei.com> <20210917174103.GC13346@blackbody.suse.cz>
In-Reply-To: <20210917174103.GC13346@blackbody.suse.cz>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Fri, 17 Sep 2021 12:58:03 -0700
Message-ID: <CACGdZYJiLuh6kED_tdWkYqbHDXc_18m-XJbevp-ri5ansvbtYg@mail.gmail.com>
Subject: Re: [RFC PATCH] blk-throttle: enable io throttle for root in cgroup v2
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000017066805cc365a3b"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000017066805cc365a3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 17, 2021 at 10:41 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hello Yu.
>
> On Thu, Sep 09, 2021 at 10:08:15PM +0800, Yu Kuai <yukuai3@huawei.com> wr=
ote:
> > I'm not sure why this feature is disabled in the first place, is
> > there any problem or design constraint?
>
> The idea for v2 is that in the root cgroup remain only kernel threads tha=
t
> provide "global" services and any user workload that should be
> constrained is put into non-root cgroups. Additionally, if kernel
> threads carry out work associated with a cgroup they can charge it to
> the respective cgroup.
>
> [snip]
> > We want to limit the overall iops/bps of the device in cgroup v2,
>
> Cui bono? (I mean what is the reason for throttling on the global level
> when there's no other entity utiliting the residual?
> <joke>Your drives are too fast?</joke>)

We'd be interested in something like this as well. (at least for
io.max). Our use case is providing remote devices which are a shared
resource. A "global" throttle like this (which is set by a local
management daemon) allows for throttling before sending network
traffic. It's also useful since we can put this throttle on a dm, so
we can enforce an aggregate throttle without needing backchannels to
coordinate multiple targets.
(This does also bring up: if this is a useful thing, would it make
sense to tie to the device, vs. requiring cgroup. We happen to use
cgroups so that requirement doesn't affect us).

Khazhy
>
> Michal

--00000000000017066805cc365a3b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmAYJKoZIhvcNAQcCoIIPiTCCD4UCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzyMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
WSYk04Mfa/vFieowTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADCBmgYIKwYBBQUHAQEE
gY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRsYXNy
M3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2Nh
Y2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvRzV2V
b4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBADnfx9bPzP8a2dQBaApDBlLv
N1ozXDmnpCJQYwEMGZ9M4eLvmEwcf46+8mad/gYr/M7OOUuUY6luyBj1pJteste0BC/ZsFpqUtaR
6CqRuUT17zyKv2K+E9ycaaCRe/jgurW0wx1BwtXRElYi+8maFYv/4AVPTFCi9YkiYGZSf/iJTpL0
/Axe5BBZ4+zrAEcLt4D+hgO1/d0uSL/VucjnCo1HgHdbdDhFFwmihXJyVpH0sHFr9ZwpeWE8vtqE
l/oCSEZn1ugqU/tYecidUqgRnBf1cc5G+fA1V45eB3j2xPBKhqRJasxH+4hFihk0/tZAzt7tnxAE
LY1X2VNMpSKLhP8xggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjACEAEC
stzjV0qUe4aermAajfswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMWprKui6Etx
CiIknhc67FUsDCc9UFqd/SSy7rqYBuIgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDkxNzE5NTgxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQATbQrK9G3URnUEG4p+T0l+sIiMkLq2
2NDa5FIFac53AGyfCzlzVLKU7ehDhgXqFkIa9oBWa8t6uDIrPFru2Jygz9H/W3y29QfoT8yOtI6a
DmeOxlTfxS12CKEjbJ5rp4gsn+4aGsQ5TRueso3xGTjXBM9WlSK2+c8OHWg+HGJBwU7uldrmcmjS
GSvKHRnNkor7igsptp/HA0LvrDgV8F/iAbKT4CEGQLCdKRRtFQa0yNWCjpbgraU2W8rADxPXx3e1
N0zfZFWzZ63h/uEEcgqKSmTi5d2XTXRrvRWkRVHfRNL23QjX2XsANHtk1Ls8b2SeeTRK9PQUDHh7
zsZxxdMS
--00000000000017066805cc365a3b--
