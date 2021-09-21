Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3198E412DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 06:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhIUEWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 00:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhIUEWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 00:22:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FBFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 21:20:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i25so76947324lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to;
        bh=HK4c2p+pAGcIpeVWyFnobNf2uYSTh4RNHc/krGBcwWE=;
        b=RFIqNHKU7FqBI+BRoER2sRg9unUZAI+Ux8akNLDHZk08wxS2CXaROJqSIBWcsvsXMr
         nHGNCkfm1mAcQIFTNw5Yxk7oFinaaaUbJn7VRuueF+6ph0UcvDJHbWiJu0RGQ+iUc52W
         CQ/aJ/LFb604hQClfkhxvGV9P2Zz29mdibkrVGebViTYt4tbTR8Qw8ZORKS2qB/byAuF
         8J4kRpWQW3cD/Xhu5ByvTPp8OTtIjN+QpdIXnBfYAFX6KA21yK5YJ0k0kSV0AJmKaBTA
         1ZAD98B+8fFWk+D2ozt06+vo/7ALvOH41Ju8LTKQZcXx1cRmQwS9J6Nth83hVDIQCiMh
         ie+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to;
        bh=HK4c2p+pAGcIpeVWyFnobNf2uYSTh4RNHc/krGBcwWE=;
        b=Nd2toKMcBfw2Yq7YDQENavuHORHzxcEL2BDV211sgqpJfJ1SSoLyr5yvfgNnhSPCuG
         k3jPum5Ah4rq4clrkJTb4QMuIG5CEQAxn8Y/19JCIBgXBo4+k4Rr5Jh3ErXc9Z0ghvUW
         VXjqUhbidzaARsfE0HT9P9HHr6SFuF2IGB7cDO2ypcKycbIlsiT3D/ojhc88Ubn4p1tX
         //pxGMXKcZZmG5KLqkseUQ1TM1Gyf7cHHp6NgzTIg4o7oE8AkOhOVvYhdawuOsOQL5f0
         DdXBu6ntOWGOeh8xF0BLlUJad/y9FklkxDWQR7jc9CryOwi0h7TdIJ+KyzEDnP+mafJD
         7Y8A==
X-Gm-Message-State: AOAM533bERva2nUhXCh/dvreIYFwhtugPknUO/2RmdJl4mKtfRCsAT6Y
        OBgYIpp53MSPQAAbBYCVoK4=
X-Google-Smtp-Source: ABdhPJyRu+XfnkzOWDRvS7dgcv4SU/SwL9HxgRfox08paVMsMU1uq8po2MGvlVbc7xVzc5Y6ABxTdQ==
X-Received: by 2002:a05:6512:ea5:: with SMTP id bi37mr22580673lfb.36.1632198034358;
        Mon, 20 Sep 2021 21:20:34 -0700 (PDT)
Received: from [10.0.0.115] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id j23sm1204717lja.125.2021.09.20.21.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 21:20:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------SUNNjoDhFfy8bEztyDsSrxya"
Message-ID: <7537b141-0ef1-fb44-7e02-27b4dd1e772b@gmail.com>
Date:   Tue, 21 Sep 2021 07:20:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kirill Marinushkin <kmarinushkin@birdec.com>,
        Mark Brown <broonie@kernel.org>
References: <2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se>
 <ae4b25f1-2b2c-d937-e23d-0f7d23bdf0c4@gmail.com>
 <815cbba4-60d6-8d97-c483-146c2f7c3912@axentia.se>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2
 registers
In-Reply-To: <815cbba4-60d6-8d97-c483-146c2f7c3912@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------SUNNjoDhFfy8bEztyDsSrxya
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter.

On 20/09/2021 22:37, Peter Rosin wrote:

> Nope, MODE1/2 are wired for I2C -> FMT is just the last I2C address
> bit. So, nothing to do with I2S. And I can't see how that would explain
> the same problem with the I2S_2 register?

true, but worth the question ;)
 
>>> This fix is not 100% correct. The datasheet of at least the pcm5142
>>> states that four bits (0xcc) in the I2S_1 register are "RSV"
>>> ("Reserved. Do not access.") and no hint is given as to what theHi
>>> initial values are supposed to be. So, specifying defaults for
>>> these bits is wrong. But perhaps better than a broken driver?
>>
>> The default of 0x02 (AFMT = 00b - I2S, ALEN = 10b - 24bits) is correct
>> for I2S_1 and the 0 is the default of I2S_2.
>>
>> The failure happens when updating the AFMT (bit4-5) and when regmap is
>> doing a i2c read since the default is not specified.
>>
>> It would be interesting to see what it is reading... Out of interest:
>> can you mar the I2S_1 and I2S_2 as volatile and read / print the value
>> just before the afmt and alen update?
> 
> My first attempt was to mark the register volatile, and then read and
> compare if the update was needed at all. But marking volatile wasn't
> enough.

If the value is not provided in the defaults then the first read is reading out to the chip anyways.

> I also tried to set both a default and mark as volatile,

Volatile always skips the cache, default would be ignored.

> but it seems every read fails with -16 (EBUSY). I don't get why, to me
> it almost feels like a regmap issue of some sort (probably the regmap
> config is bad in some way), but I'm not fluent in regmap...

Or most likely the chip is not powered at pcm512x_set_fmt() time?

> So, since I can't read, I can't get to the initial values of the four
> reserved bits. So, I winged them as zero.

The value of the reserved bits are don't care.

Can you try the attached patch w/o without the defaults for i2s_1/2?
Not even compile tested...

From e013a03286b6a744914c50239d3123b7723068df Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Date: Tue, 21 Sep 2021 07:12:06 +0300
Subject: [PATCH] ASoC: pcm512x: test regmap register accesses

read i2c_1 in different stages.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 sound/soc/codecs/pcm512x.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 4dc844f3c1fc..d0382e9ac329 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1166,6 +1166,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+	unsigned int val;
 	int alen;
 	int gpio;
 	int ret;
@@ -1193,6 +1194,18 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	ret = regmap_read(pcm512x->regmap, PCM512x_I2S_1, &val);
+	if (ret) {
+		dev_err(component->dev, "%s: failed to read I2S_1: %d\n", __func_, ret);
+		ret = regmap_read(pcm512x->regmap, PCM512x_PLL_EN, &val);
+		if (ret)
+			dev_err(component->dev, "%s: failed to read PLL_EN: %d\n", __func__, ret);
+		else
+			dev_err(component->dev, "%s: PLL_EN: %#x\n", __func__, val);
+	} else {
+		dev_err(component->dev, "%s: I2S_1: %#x\n", __func__, val);
+	}
+
 	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_1,
 				 PCM512x_ALEN, alen);
 	if (ret != 0) {
@@ -1335,6 +1348,7 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+	unsigned int val;
 	int afmt;
 	int offset = 0;
 	int clock_output;
@@ -1396,18 +1410,28 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	ret = regmap_read(pcm512x->regmap, PCM512x_I2S_1, &val);
+	if (ret) {
+		dev_err(component->dev, "%s: failed to read I2S_1: %d\n", __func_, ret);
+		ret = regmap_read(pcm512x->regmap, PCM512x_PLL_EN, &val);
+		if (ret)
+			dev_err(component->dev, "%s: failed to read PLL_EN: %d\n", __func__, ret);
+		else
+			dev_err(component->dev, "%s: PLL_EN: %#x\n", __func__, val);
+	} else {
+		dev_err(component->dev, "%s: I2S_1: %#x\n", __func__, val);
+	}
+
 	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_1,
 				 PCM512x_AFMT, afmt);
 	if (ret != 0) {
 		dev_err(component->dev, "Failed to set data format: %d\n", ret);
-		return ret;
 	}
 
 	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_2,
 				 0xFF, offset);
 	if (ret != 0) {
 		dev_err(component->dev, "Failed to set data offset: %d\n", ret);
-		return ret;
 	}
 
 	pcm512x->fmt = fmt;
-- 
2.33.0



-- 
Péter
--------------SUNNjoDhFfy8bEztyDsSrxya
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ASoC-pcm512x-test-regmap-register-accesses.patch"
Content-Disposition: attachment;
 filename="0001-ASoC-pcm512x-test-regmap-register-accesses.patch"
Content-Transfer-Encoding: base64

RnJvbSBlMDEzYTAzMjg2YjZhNzQ0OTE0YzUwMjM5ZDMxMjNiNzcyMzA2OGRmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1c2lA
Z21haWwuY29tPgpEYXRlOiBUdWUsIDIxIFNlcCAyMDIxIDA3OjEyOjA2ICswMzAwClN1Ympl
Y3Q6IFtQQVRDSF0gQVNvQzogcGNtNTEyeDogdGVzdCByZWdtYXAgcmVnaXN0ZXIgYWNjZXNz
ZXMKCnJlYWQgaTJjXzEgaW4gZGlmZmVyZW50IHN0YWdlcy4KClNpZ25lZC1vZmYtYnk6IFBl
dGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUBnbWFpbC5jb20+Ci0tLQogc291bmQvc29j
L2NvZGVjcy9wY201MTJ4LmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3BjbTUxMnguYyBiL3NvdW5kL3NvYy9jb2RlY3Mv
cGNtNTEyeC5jCmluZGV4IDRkYzg0NGYzYzFmYy4uZDAzODJlOWFjMzI5IDEwMDY0NAotLS0g
YS9zb3VuZC9zb2MvY29kZWNzL3BjbTUxMnguYworKysgYi9zb3VuZC9zb2MvY29kZWNzL3Bj
bTUxMnguYwpAQCAtMTE2Niw2ICsxMTY2LDcgQEAgc3RhdGljIGludCBwY201MTJ4X2h3X3Bh
cmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKIHsKIAlzdHJ1Y3Qg
c25kX3NvY19jb21wb25lbnQgKmNvbXBvbmVudCA9IGRhaS0+Y29tcG9uZW50OwogCXN0cnVj
dCBwY201MTJ4X3ByaXYgKnBjbTUxMnggPSBzbmRfc29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0
YShjb21wb25lbnQpOworCXVuc2lnbmVkIGludCB2YWw7CiAJaW50IGFsZW47CiAJaW50IGdw
aW87CiAJaW50IHJldDsKQEAgLTExOTMsNiArMTE5NCwxOCBAQCBzdGF0aWMgaW50IHBjbTUx
MnhfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQly
ZXR1cm4gLUVJTlZBTDsKIAl9CiAKKwlyZXQgPSByZWdtYXBfcmVhZChwY201MTJ4LT5yZWdt
YXAsIFBDTTUxMnhfSTJTXzEsICZ2YWwpOworCWlmIChyZXQpIHsKKwkJZGV2X2Vycihjb21w
b25lbnQtPmRldiwgIiVzOiBmYWlsZWQgdG8gcmVhZCBJMlNfMTogJWRcbiIsIF9fZnVuY18s
IHJldCk7CisJCXJldCA9IHJlZ21hcF9yZWFkKHBjbTUxMngtPnJlZ21hcCwgUENNNTEyeF9Q
TExfRU4sICZ2YWwpOworCQlpZiAocmV0KQorCQkJZGV2X2Vycihjb21wb25lbnQtPmRldiwg
IiVzOiBmYWlsZWQgdG8gcmVhZCBQTExfRU46ICVkXG4iLCBfX2Z1bmNfXywgcmV0KTsKKwkJ
ZWxzZQorCQkJZGV2X2Vycihjb21wb25lbnQtPmRldiwgIiVzOiBQTExfRU46ICUjeFxuIiwg
X19mdW5jX18sIHZhbCk7CisJfSBlbHNlIHsKKwkJZGV2X2Vycihjb21wb25lbnQtPmRldiwg
IiVzOiBJMlNfMTogJSN4XG4iLCBfX2Z1bmNfXywgdmFsKTsKKwl9CisKIAlyZXQgPSByZWdt
YXBfdXBkYXRlX2JpdHMocGNtNTEyeC0+cmVnbWFwLCBQQ001MTJ4X0kyU18xLAogCQkJCSBQ
Q001MTJ4X0FMRU4sIGFsZW4pOwogCWlmIChyZXQgIT0gMCkgewpAQCAtMTMzNSw2ICsxMzQ4
LDcgQEAgc3RhdGljIGludCBwY201MTJ4X3NldF9mbXQoc3RydWN0IHNuZF9zb2NfZGFpICpk
YWksIHVuc2lnbmVkIGludCBmbXQpCiB7CiAJc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpj
b21wb25lbnQgPSBkYWktPmNvbXBvbmVudDsKIAlzdHJ1Y3QgcGNtNTEyeF9wcml2ICpwY201
MTJ4ID0gc25kX3NvY19jb21wb25lbnRfZ2V0X2RydmRhdGEoY29tcG9uZW50KTsKKwl1bnNp
Z25lZCBpbnQgdmFsOwogCWludCBhZm10OwogCWludCBvZmZzZXQgPSAwOwogCWludCBjbG9j
a19vdXRwdXQ7CkBAIC0xMzk2LDE4ICsxNDEwLDI4IEBAIHN0YXRpYyBpbnQgcGNtNTEyeF9z
ZXRfZm10KHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpLCB1bnNpZ25lZCBpbnQgZm10KQogCQly
ZXR1cm4gLUVJTlZBTDsKIAl9CiAKKwlyZXQgPSByZWdtYXBfcmVhZChwY201MTJ4LT5yZWdt
YXAsIFBDTTUxMnhfSTJTXzEsICZ2YWwpOworCWlmIChyZXQpIHsKKwkJZGV2X2Vycihjb21w
b25lbnQtPmRldiwgIiVzOiBmYWlsZWQgdG8gcmVhZCBJMlNfMTogJWRcbiIsIF9fZnVuY18s
IHJldCk7CisJCXJldCA9IHJlZ21hcF9yZWFkKHBjbTUxMngtPnJlZ21hcCwgUENNNTEyeF9Q
TExfRU4sICZ2YWwpOworCQlpZiAocmV0KQorCQkJZGV2X2Vycihjb21wb25lbnQtPmRldiwg
IiVzOiBmYWlsZWQgdG8gcmVhZCBQTExfRU46ICVkXG4iLCBfX2Z1bmNfXywgcmV0KTsKKwkJ
ZWxzZQorCQkJZGV2X2Vycihjb21wb25lbnQtPmRldiwgIiVzOiBQTExfRU46ICUjeFxuIiwg
X19mdW5jX18sIHZhbCk7CisJfSBlbHNlIHsKKwkJZGV2X2Vycihjb21wb25lbnQtPmRldiwg
IiVzOiBJMlNfMTogJSN4XG4iLCBfX2Z1bmNfXywgdmFsKTsKKwl9CisKIAlyZXQgPSByZWdt
YXBfdXBkYXRlX2JpdHMocGNtNTEyeC0+cmVnbWFwLCBQQ001MTJ4X0kyU18xLAogCQkJCSBQ
Q001MTJ4X0FGTVQsIGFmbXQpOwogCWlmIChyZXQgIT0gMCkgewogCQlkZXZfZXJyKGNvbXBv
bmVudC0+ZGV2LCAiRmFpbGVkIHRvIHNldCBkYXRhIGZvcm1hdDogJWRcbiIsIHJldCk7Ci0J
CXJldHVybiByZXQ7CiAJfQogCiAJcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRzKHBjbTUxMngt
PnJlZ21hcCwgUENNNTEyeF9JMlNfMiwKIAkJCQkgMHhGRiwgb2Zmc2V0KTsKIAlpZiAocmV0
ICE9IDApIHsKIAkJZGV2X2Vycihjb21wb25lbnQtPmRldiwgIkZhaWxlZCB0byBzZXQgZGF0
YSBvZmZzZXQ6ICVkXG4iLCByZXQpOwotCQlyZXR1cm4gcmV0OwogCX0KIAogCXBjbTUxMngt
PmZtdCA9IGZtdDsKLS0gCjIuMzMuMAoK
--------------SUNNjoDhFfy8bEztyDsSrxya--

