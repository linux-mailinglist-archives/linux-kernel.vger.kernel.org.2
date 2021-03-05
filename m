Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD332F0DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhCERLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:11:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231390AbhCERKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:10:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A1FA65098;
        Fri,  5 Mar 2021 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614964242;
        bh=Odsp/noRardX3DRBJFRkNPZbANnsXaLDsADcJBR4D04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVT7b374h1Q2k2AmJ199GRKgcFNXPoJAvXDPxUG31HQg6BtRKVDp3B7/dIrJE80E+
         Qx8LlKr+dQxVJjl7gyaTW8xue5amp/YAN9/gA+aBEgiqOFRK10P8LxnvpbRob3PmM0
         hKo3/WiwV8gQuKi8TbGZ/VdVE9+O0WU/igY6UVTafR2eZ/fa/YBSXo11MrXxFk2qx5
         NLOkz45gZPylwJ55XsUXg07yQONDAXPnlqVN6wKkKMqWRbadIaWizgl6jKfEa8lqCx
         SeEqhZ+Xega0BmePJM2FnVuDvsbPOpZ3sPhUPpdedWnNHAkoWFH9ozehdDdAjTKoVl
         q0VLERsYeJbLQ==
Date:   Fri, 5 Mar 2021 19:10:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v10 4/9] ecdsa: Register NIST P384 and extend test suite
Message-ID: <YEJl/SxdisIJxncp@kernel.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-5-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305005203.3547587-5-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:51:58PM -0500, Stefan Berger wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> 
> * crypto/ecdsa.c
>   - add ecdsa_nist_p384_init_tfm
>   - register and unregister P384 tfm
> 
> * crypto/testmgr.c
>   - add test vector for P384 on vector of tests
> 
> * crypto/testmgr.h
>   - add test vector params for P384(sha1, sha224, sha256, sha384
>     and sha512)
> 
> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

"diffstat"

/Jarkko

> ---
>  crypto/ecdsa.c   |  33 +++++++++-
>  crypto/testmgr.c |   6 ++
>  crypto/testmgr.h | 157 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 04fbb3d2abc5..8cce80e4154e 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -145,7 +145,7 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash,
>  
>  	/* res.x = res.x mod n (if res.x > order) */
>  	if (unlikely(vli_cmp(res.x, curve->n, ndigits) == 1))
> -		/* faster alternative for NIST p256 & p192 */
> +		/* faster alternative for NIST p384, p256 & p192 */
>  		vli_sub(res.x, res.x, curve->n, ndigits);
>  
>  	if (!vli_cmp(res.x, r, ndigits))
> @@ -289,6 +289,28 @@ static unsigned int ecdsa_max_size(struct crypto_akcipher *tfm)
>  	return ctx->pub_key.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
>  }
>  
> +static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
> +{
> +	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
> +
> +	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P384);
> +}
> +
> +static struct akcipher_alg ecdsa_nist_p384 = {
> +	.verify = ecdsa_verify,
> +	.set_pub_key = ecdsa_set_pub_key,
> +	.max_size = ecdsa_max_size,
> +	.init = ecdsa_nist_p384_init_tfm,
> +	.exit = ecdsa_exit_tfm,
> +	.base = {
> +		.cra_name = "ecdsa-nist-p384",
> +		.cra_driver_name = "ecdsa-nist-p384-generic",
> +		.cra_priority = 100,
> +		.cra_module = THIS_MODULE,
> +		.cra_ctxsize = sizeof(struct ecc_ctx),
> +	},
> +};
> +
>  static int ecdsa_nist_p256_init_tfm(struct crypto_akcipher *tfm)
>  {
>  	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
> @@ -345,8 +367,16 @@ static int ecdsa_init(void)
>  	ret = crypto_register_akcipher(&ecdsa_nist_p256);
>  	if (ret)
>  		goto nist_p256_error;
> +
> +	ret = crypto_register_akcipher(&ecdsa_nist_p384);
> +	if (ret)
> +		goto nist_p384_error;
> +
>  	return 0;
>  
> +nist_p384_error:
> +	crypto_unregister_akcipher(&ecdsa_nist_p256);
> +
>  nist_p256_error:
>  	if (ecdsa_nist_p192_registered)
>  		crypto_unregister_akcipher(&ecdsa_nist_p192);
> @@ -358,6 +388,7 @@ static void ecdsa_exit(void)
>  	if (ecdsa_nist_p192_registered)
>  		crypto_unregister_akcipher(&ecdsa_nist_p192);
>  	crypto_unregister_akcipher(&ecdsa_nist_p256);
> +	crypto_unregister_akcipher(&ecdsa_nist_p384);
>  }
>  
>  subsys_initcall(ecdsa_init);
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 2607602f9de5..08f85719338a 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -4925,6 +4925,12 @@ static const struct alg_test_desc alg_test_descs[] = {
>  		.suite = {
>  			.akcipher = __VECS(ecdsa_nist_p256_tv_template)
>  		}
> +	}, {
> +		.alg = "ecdsa-nist-p384",
> +		.test = alg_test_akcipher,
> +		.suite = {
> +			.akcipher = __VECS(ecdsa_nist_p384_tv_template)
> +		}
>  	}, {
>  		.alg = "ecrdsa",
>  		.test = alg_test_akcipher,
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index 2adcc0dc0bdd..e63a760aca2d 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -833,6 +833,163 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
>  	},
>  };
>  
> +static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
> +	{
> +	.key = /* secp384r1(sha1) */
> +	"\x04\x89\x25\xf3\x97\x88\xcb\xb0\x78\xc5\x72\x9a\x14\x6e\x7a\xb1"
> +	"\x5a\xa5\x24\xf1\x95\x06\x9e\x28\xfb\xc4\xb9\xbe\x5a\x0d\xd9\x9f"
> +	"\xf3\xd1\x4d\x2d\x07\x99\xbd\xda\xa7\x66\xec\xbb\xea\xba\x79\x42"
> +	"\xc9\x34\x89\x6a\xe7\x0b\xc3\xf2\xfe\x32\x30\xbe\xba\xf9\xdf\x7e"
> +	"\x4b\x6a\x07\x8e\x26\x66\x3f\x1d\xec\xa2\x57\x91\x51\xdd\x17\x0e"
> +	"\x0b\x25\xd6\x80\x5c\x3b\xe6\x1a\x98\x48\x91\x45\x7a\x73\xb0\xc3"
> +	"\xf1",
> +	.key_len = 97,
> +	.params =
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x22",
> +	.param_len = 18,
> +	.m =
> +	"\x12\x55\x28\xf0\x77\xd5\xb6\x21\x71\x32\x48\xcd\x28\xa8\x25\x22"
> +	"\x3a\x69\xc1\x93",
> +	.m_size = 20,
> +	.algo = OID_id_ecdsa_with_sha1,
> +	.c =
> +	"\x30\x66\x02\x31\x00\xf5\x0f\x24\x4c\x07\x93\x6f\x21\x57\x55\x07"
> +	"\x20\x43\x30\xde\xa0\x8d\x26\x8e\xae\x63\x3f\xbc\x20\x3a\xc6\xf1"
> +	"\x32\x3c\xce\x70\x2b\x78\xf1\x4c\x26\xe6\x5b\x86\xcf\xec\x7c\x7e"
> +	"\xd0\x87\xd7\xd7\x6e\x02\x31\x00\xcd\xbb\x7e\x81\x5d\x8f\x63\xc0"
> +	"\x5f\x63\xb1\xbe\x5e\x4c\x0e\xa1\xdf\x28\x8c\x1b\xfa\xf9\x95\x88"
> +	"\x74\xa0\x0f\xbf\xaf\xc3\x36\x76\x4a\xa1\x59\xf1\x1c\xa4\x58\x26"
> +	"\x79\x12\x2a\xb7\xc5\x15\x92\xc5",
> +	.c_size = 104,
> +	.public_key_vec = true,
> +	.siggen_sigver_test = true,
> +	}, {
> +	.key = /* secp384r1(sha224) */
> +	"\x04\x69\x6c\xcf\x62\xee\xd0\x0d\xe5\xb5\x2f\x70\x54\xcf\x26\xa0"
> +	"\xd9\x98\x8d\x92\x2a\xab\x9b\x11\xcb\x48\x18\xa1\xa9\x0d\xd5\x18"
> +	"\x3e\xe8\x29\x6e\xf6\xe4\xb5\x8e\xc7\x4a\xc2\x5f\x37\x13\x99\x05"
> +	"\xb6\xa4\x9d\xf9\xfb\x79\x41\xe7\xd7\x96\x9f\x73\x3b\x39\x43\xdc"
> +	"\xda\xf4\x06\xb9\xa5\x29\x01\x9d\x3b\xe1\xd8\x68\x77\x2a\xf4\x50"
> +	"\x6b\x93\x99\x6c\x66\x4c\x42\x3f\x65\x60\x6c\x1c\x0b\x93\x9b\x9d"
> +	"\xe0",
> +	.key_len = 97,
> +	.params =
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x22",
> +	.param_len = 18,
> +	.m =
> +	"\x12\x80\xb6\xeb\x25\xe2\x3d\xf0\x21\x32\x96\x17\x3a\x38\x39\xfd"
> +	"\x1f\x05\x34\x7b\xb8\xf9\x71\x66\x03\x4f\xd5\xe5",
> +	.m_size = 28,
> +	.algo = OID_id_ecdsa_with_sha224,
> +	.c =
> +	"\x30\x66\x02\x31\x00\x8a\x51\x84\xce\x13\x1e\xd2\xdc\xec\xcb\xe4"
> +	"\x89\x47\xb2\xf7\xbc\x97\xf1\xc8\x72\x26\xcf\x5a\x5e\xc5\xda\xb4"
> +	"\xe3\x93\x07\xe0\x99\xc9\x9c\x11\xb8\x10\x01\xc5\x41\x3f\xdd\x15"
> +	"\x1b\x68\x2b\x9d\x8b\x02\x31\x00\x8b\x03\x2c\xfc\x1f\xd1\xa9\xa4"
> +	"\x4b\x00\x08\x31\x6c\xf5\xd5\xf6\xdf\xd8\x68\xa2\x64\x42\x65\xf3"
> +	"\x4d\xd0\xc6\x6e\xb0\xe9\xfc\x14\x9f\x19\xd0\x42\x8b\x93\xc2\x11"
> +	"\x88\x2b\x82\x26\x5e\x1c\xda\xfb",
> +	.c_size = 104,
> +	.public_key_vec = true,
> +	.siggen_sigver_test = true,
> +	}, {
> +	.key = /* secp384r1(sha256) */
> +	"\x04\xee\xd6\xda\x3e\x94\x90\x00\x27\xed\xf8\x64\x55\xd6\x51\x9a"
> +	"\x1f\x52\x00\x63\x78\xf1\xa9\xfd\x75\x4c\x9e\xb2\x20\x1a\x91\x5a"
> +	"\xba\x7a\xa3\xe5\x6c\xb6\x25\x68\x4b\xe8\x13\xa6\x54\x87\x2c\x0e"
> +	"\xd0\x83\x95\xbc\xbf\xc5\x28\x4f\x77\x1c\x46\xa6\xf0\xbc\xd4\xa4"
> +	"\x8d\xc2\x8f\xb3\x32\x37\x40\xd6\xca\xf8\xae\x07\x34\x52\x39\x52"
> +	"\x17\xc3\x34\x29\xd6\x40\xea\x5c\xb9\x3f\xfb\x32\x2e\x12\x33\xbc"
> +	"\xab",
> +	.key_len = 97,
> +	.params =
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x22",
> +	.param_len = 18,
> +	.m =
> +	"\xaa\xe7\xfd\x03\x26\xcb\x94\x71\xe4\xce\x0f\xc5\xff\xa6\x29\xa3"
> +	"\xe1\xcc\x4c\x35\x4e\xde\xca\x80\xab\x26\x0c\x25\xe6\x68\x11\xc2",
> +	.m_size = 32,
> +	.algo = OID_id_ecdsa_with_sha256,
> +	.c =
> +	"\x30\x64\x02\x30\x08\x09\x12\x9d\x6e\x96\x64\xa6\x8e\x3f\x7e\xce"
> +	"\x0a\x9b\xaa\x59\xcc\x47\x53\x87\xbc\xbd\x83\x3f\xaf\x06\x3f\x84"
> +	"\x04\xe2\xf9\x67\xb6\xc6\xfc\x70\x2e\x66\x3c\x77\xc8\x8d\x2c\x79"
> +	"\x3a\x8e\x32\xc4\x02\x30\x40\x34\xb8\x90\xa9\x80\xab\x47\x26\xa2"
> +	"\xb0\x89\x42\x0a\xda\xd9\xdd\xce\xbc\xb2\x97\xf4\x9c\xf3\x15\x68"
> +	"\xc0\x75\x3e\x23\x5e\x36\x4f\x8d\xde\x1e\x93\x8d\x95\xbb\x10\x0e"
> +	"\xf4\x1f\x39\xca\x4d\x43",
> +	.c_size = 102,
> +	.public_key_vec = true,
> +	.siggen_sigver_test = true,
> +	}, {
> +	.key = /* secp384r1(sha384) */
> +	"\x04\x3a\x2f\x62\xe7\x1a\xcf\x24\xd0\x0b\x7c\xe0\xed\x46\x0a\x4f"
> +	"\x74\x16\x43\xe9\x1a\x25\x7c\x55\xff\xf0\x29\x68\x66\x20\x91\xf9"
> +	"\xdb\x2b\xf6\xb3\x6c\x54\x01\xca\xc7\x6a\x5c\x0d\xeb\x68\xd9\x3c"
> +	"\xf1\x01\x74\x1f\xf9\x6c\xe5\x5b\x60\xe9\x7f\x5d\xb3\x12\x80\x2a"
> +	"\xd8\x67\x92\xc9\x0e\x4c\x4c\x6b\xa1\xb2\xa8\x1e\xac\x1c\x97\xd9"
> +	"\x21\x67\xe5\x1b\x5a\x52\x31\x68\xd6\xee\xf0\x19\xb0\x55\xed\x89"
> +	"\x9e",
> +	.key_len = 97,
> +	.params =
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x22",
> +	.param_len = 18,
> +	.m =
> +	"\x8d\xf2\xc0\xe9\xa8\xf3\x8e\x44\xc4\x8c\x1a\xa0\xb8\xd7\x17\xdf"
> +	"\xf2\x37\x1b\xc6\xe3\xf5\x62\xcc\x68\xf5\xd5\x0b\xbf\x73\x2b\xb1"
> +	"\xb0\x4c\x04\x00\x31\xab\xfe\xc8\xd6\x09\xc8\xf2\xea\xd3\x28\xff",
> +	.m_size = 48,
> +	.algo = OID_id_ecdsa_with_sha384,
> +	.c =
> +	"\x30\x66\x02\x31\x00\x9b\x28\x68\xc0\xa1\xea\x8c\x50\xee\x2e\x62"
> +	"\x35\x46\xfa\x00\xd8\x2d\x7a\x91\x5f\x49\x2d\x22\x08\x29\xe6\xfb"
> +	"\xca\x8c\xd6\xb6\xb4\x3b\x1f\x07\x8f\x15\x02\xfe\x1d\xa2\xa4\xc8"
> +	"\xf2\xea\x9d\x11\x1f\x02\x31\x00\xfc\x50\xf6\x43\xbd\x50\x82\x0e"
> +	"\xbf\xe3\x75\x24\x49\xac\xfb\xc8\x71\xcd\x8f\x18\x99\xf0\x0f\x13"
> +	"\x44\x92\x8c\x86\x99\x65\xb3\x97\x96\x17\x04\xc9\x05\x77\xf1\x8e"
> +	"\xab\x8d\x4e\xde\xe6\x6d\x9b\x66",
> +	.c_size = 104,
> +	.public_key_vec = true,
> +	.siggen_sigver_test = true,
> +	}, {
> +	.key = /* secp384r1(sha512) */
> +	"\x04\xb4\xe7\xc1\xeb\x64\x25\x22\x46\xc3\x86\x61\x80\xbe\x1e\x46"
> +	"\xcb\xf6\x05\xc2\xee\x73\x83\xbc\xea\x30\x61\x4d\x40\x05\x41\xf4"
> +	"\x8c\xe3\x0e\x5c\xf0\x50\xf2\x07\x19\xe8\x4f\x25\xbe\xee\x0c\x95"
> +	"\x54\x36\x86\xec\xc2\x20\x75\xf3\x89\xb5\x11\xa1\xb7\xf5\xaf\xbe"
> +	"\x81\xe4\xc3\x39\x06\xbd\xe4\xfe\x68\x1c\x6d\x99\x2b\x1b\x63\xfa"
> +	"\xdf\x42\x5c\xc2\x5a\xc7\x0c\xf4\x15\xf7\x1b\xa3\x2e\xd7\x00\xac"
> +	"\xa3",
> +	.key_len = 97,
> +	.params =
> +	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> +	"\x00\x22",
> +	.param_len = 18,
> +	.m =
> +	"\xe8\xb7\x52\x7d\x1a\x44\x20\x05\x53\x6b\x3a\x68\xf2\xe7\x6c\xa1"
> +	"\xae\x9d\x84\xbb\xba\x52\x43\x3e\x2c\x42\x78\x49\xbf\x78\xb2\x71"
> +	"\xeb\xe1\xe0\xe8\x42\x7b\x11\xad\x2b\x99\x05\x1d\x36\xe6\xac\xfc"
> +	"\x55\x73\xf0\x15\x63\x39\xb8\x6a\x6a\xc5\x91\x5b\xca\x6a\xa8\x0e",
> +	.m_size = 64,
> +	.algo = OID_id_ecdsa_with_sha512,
> +	.c =
> +	"\x30\x63\x02\x2f\x1d\x20\x94\x77\xfe\x31\xfa\x4d\xc6\xef\xda\x02"
> +	"\xe7\x0f\x52\x9a\x02\xde\x93\xe8\x83\xe4\x84\x4c\xfc\x6f\x80\xe3"
> +	"\xaf\xb3\xd9\xdc\x2b\x43\x0e\x6a\xb3\x53\x6f\x3e\xb3\xc7\xa8\xb3"
> +	"\x17\x77\xd1\x02\x30\x63\xf6\xf0\x3d\x5f\x5f\x99\x3f\xde\x3a\x3d"
> +	"\x16\xaf\xb4\x52\x6a\xec\x63\xe3\x0c\xec\x50\xdc\xcc\xc4\x6a\x03"
> +	"\x5f\x8d\x7a\xf9\xfb\x34\xe4\x8b\x80\xa5\xb6\xda\x2c\x4e\x45\xcf"
> +	"\x3c\x93\xff\x50\x5d",
> +	.c_size = 101,
> +	.public_key_vec = true,
> +	.siggen_sigver_test = true,
> +	},
> +};
> +
>  /*
>   * EC-RDSA test vectors are generated by gost-engine.
>   */
> -- 
> 2.29.2
> 
> 
