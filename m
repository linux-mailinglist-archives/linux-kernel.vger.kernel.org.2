Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA934DD27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhC3Aki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:40:38 -0400
Received: from sonic315-55.consmr.mail.gq1.yahoo.com ([98.137.65.31]:43123
        "EHLO sonic315-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230512AbhC3AkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1617064811; bh=ZoUtl34DQ5AX85R9xNUqq64te7dcd9foFuy2vWRE7aA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oklsSbxC4SJVYuNbmNKmvZHF7HYFWhWi7U6/BhGPGl665vze2ld8CPGSjD9dJLV0k+pDjU/1rtKxJUlF/tAzUrHx+XFGXjKIg+TvhecJi0j4MvfHkFvtXuTq7nKyfRnjjSV9Z6Kz8cQQIhb1YvPgyjPyZnbIu/zZV6q2aB60xsao9v8iC3jAvkbQwD5gLF0QxYiTdUM9f6gJZVIYitzMEOdQ7g2ozSjakOwrIPfzsRJYaTJ9ywB0NMULj6pfa6IDGVcGTXmCmxk5/Jw3eQVxAOuI178tFulUQ2LGkkoH0/K5vR4puvTJDfUKKAbyzTJiy+Isvl9KvxgsoEDQ/xHNqA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617064811; bh=U1EetIHGLRHV26dXcPnpnsTSql62T5euMfsiv2UHvUM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SBqMc1ofJ5AP0EZTlWZEykLspEgbna3scbkttQmGU+aze/gSIbMMVcLu2K40wE8N88vjLd+15gXRhjdlhMPnHZ+9CRuPUDzTEIiCECa4eLwzRITCGJCnLOhQNb4Dm6a70E+05ULrqUGRqD3mEt892qv/ClRrLBzlgXdj4Fb1z9h+bo5ilXLjJEVlTUZ/vmEt360qSEY1pg5yr3yitUKIxwui8MM41K3otCPpUeU5zWhODwPGyEcmAZL77R4I7T573ijfmfmK+Pa49KYlnpxD79EG+ncuKAr5OHg5JNTCCb+w2hkn/j+rFW98VUduXvzea3WS+ehX5zT14gGSRlIAEw==
X-YMail-OSG: URrF1z4VM1nnL6rXos5uWcuFX5Po1UjU8Ztmer0K5ytVbQSdMiYJw0YItF6KLrr
 2r1R6uBQjLtkfujvsJ4TfxQ1KyPBRYi2wfjv7E3s.6MOl4N.O2DidYiTxORSCtI.AEUIj7zrsI8q
 0gLxtfdpRQa6w2ULgO2Mv73BM5dgeUMUXlGCe2FsLl2G0ZNiQty5KBHGlH4Ie9Euz.47EScLuPc.
 sJw7qNLffuesTNIBqzla6Fhtdi8IUiftJdbfBNaGYJcbvK6dYMz6_6MiDFwgXR8.aIGs84HWWsgj
 xJHBNX1prGR76jIbg5NXSJBCTu24F4nzS1sUcdRaZU1Xpy3uL8.mKxz3QWupITaN304paqpw3n8M
 roousn20z6dblY0vs4COu_InrnpiPhy9mxXsRG3e6Din.WukNuRR_F8ObBRb4GP7mbR_kvUeevyh
 MYd5FruBbI7ozJUBmtepmKrl_sxtoPtS5S3Sc_v0gNmECYwZJ163tux7XcFnOgiz_skmq3KuYFq7
 dm.Eqb_kgAMMQciTMdOGRJe0jP.ESbrBYVEuohLujFbbjJGtVcmBM_.JEOdZvH6jxOkEsnSTN9IR
 qsfLwE6GTcLhP5efztRNk9uKtdKSUEaxh8mQzrrlvD36STxN6ruzJcqFD3mnAE0eXKI1gp8jQ4hp
 ijyZOBKUrzkRXpylDIO17V6CNiT6oQt7D_cuN0h2Fl.ULgzB6wZ64CMrZGnFbZUDQYfCeJdj7LXT
 pdpADLGffYxmq1fhK_H2noMDfh5eBrjtZus2GjN5Xmb5ZH2b0iv4GuFY0N0_OsfR.QJu8oTVXiR1
 exd.uuaeEf_rnf25aHomhdbxxSM4QYRp62swrPhOZjYPdI25sxN6itkzVQrSTTzCTCpv0R0aGFUA
 J_I8_FWrGjY.eZRYAExcHZP1sTi1AZMeghuIHsqkiMZ3CnTZH9gTNt.tY9vhTs577muG.Te4Y31B
 368JALGeS3v1kjCb3icKcJDWxJDyunBQuXQJLGq7eo4NABNqfuY.mBUU4WhXk1AM56wIhRzv5Opn
 KvN6c1OXDcBwI4XZ5Pnq7U5ZorkjcOcLEuwqJz2v9D1Mw2DIxbHOxjt19bHjoGLtp7GG0TlPqLMp
 n4HBSVFu_cTbWpcvPZ_GXqRO54SLJOB.qYWbzLaQSFAnF1s9BNRhaBxuHbrHvEpvwQQ0GPgcE710
 TEd.y1NMIr_cnhcDplYJN8hJaB8GD7BKuhTMOS2hPTIOk3qTzuLDGI.vBKEoq2NVO.Muxe5gq3Vg
 RKrmrsxpwaxcPjDQYKCE8Tje68f37JOBMIOskLS2wNPnQHW05iZ5PPXDHJoVgMwvGAaJZr86IuPr
 bpoEpqpUyrp8vaZ43gozgmXWqZuZp.OYKTCDBaR8LAL6mbA5y3qVUW4T4PXclqQx8lTeT61QtUVL
 gV_zTqhgoPMWqO9egYbjL_7CtJ13Rs8kQKKY2M.DwwThFuQAfF74vmHL8OsNDWdwMoOo17sFWl3b
 EKJKfzs97bQ1fsfTvJVqV_CVLseT.Wr5AVR9nQsHefOqWcySbygh0HY73vHuCoPWQ_W1ZxczOwOJ
 l6py_NWeYJtPWYQvawbzZC8bXXvrZHkZVYQiFZ_VWxHB_wsZPRKy4L3Ydb2iE9_Ew79WLi2pDmpW
 l6syBr4qCbCahk1CnRSzf5MCdpE2tm5C_x_fOkCHaKWPeKd4rmp9VqJ3hLc4Z2l2wOV_XJb6EkCK
 LR0S33vYNmEtOPsVoPsSH43OLcO9pGhdnqzZ4V7XT5rPceBxSdDO_hq0MYjIEpWupperOuib2Knn
 JxHYAFpjLJyc5izIgGb_yv3GFqR2lamgXCA7nhXAUxWZsv7oZK3sj2uqQ_ej6Bjd2JGI_hd1t2LS
 7udZbdHD_048ueYwU04HH.EAKcjXrI7YWNYmwP8P0QuFM7iSQ7befn1mDdZaR8_2ug0bel2990_i
 7oEw.uAdrquFfJyGKOP0KT4NJ2Sx6kBpv6Mm2gWkcmIGQiQqL9LWXfsAR3HCtBbKwiD2wJ7Cjbuz
 rF9Gx2uYuIJdMcTuXcxqfLH5TyaidhWPBxGoqvLp5esyq6Vt0o3aYYa.QeAq6ceiS2UHcZfKoiAg
 uGgqveVmGXYJSXWvj4lG9wgCM7tOLkkXM.9kOrw0oKzBgU7lmTfZy00782qK4lcbnUS1thtDY89Z
 afhocvvpTa4x5XU69gqO1FNVkt9Wc63gGXNYNCuxnJOXvV1gxIUrcvzGh4oIppiQHHrIkId60K8_
 6Fyj5N9kRw1ZAt4Px8MUanDAoOO5KtIKz_wJp8msFTDfi9XP0cDbSdGC1Ojezf2t3eA9prO0KnPw
 9xwHeZgBysj7gNcfL7V7xCRmkH1W_sFFRkIfvw5XKxLzKa59twhtueWzU2yT58t4s7_OqkLHFdv1
 pzy2nCM12KGn.46VVN4CH5eR4YYMhsjNs6WqKnMES53mfrnfGGc6CsGz_TI1S4mrf5480sQh9ec0
 4tZQ56NnbKoa.8bPW5cGo5zJzfYFpzZ4GE95DEbEK3eGJppojpi3ACrbX4_YWqwa.vpo3rcL4f6M
 Qg0dCAntuWvwPD9QqdJ4vFUJeJE6DvNWNxB_ATu9pv_GLASQo.DFF17QTZyCk45An2yW0aPTs_lP
 8XHC7dv2c98VM6oxst0VkIMIl7seaW14DTKIeutryH5xPlQFWsGN2uiHbMHhh2cJ53NcOTRwVi67
 PYV0Hc41P2WjhHm_5XYJJh07x2na1_w88xU.f6aR8SQ0U7n0zoKboyN0LO7.7Vrs2FNGvhAfa758
 IQ1d4oIUCbHthL9idzYYm1Pf8S1Ph37oWd0DLj0HlFLyUCm3Yjiy3218XbZUUxQc6qtDzdnOQz2N
 mP55lDvnbvzFNxlB16TG462tGGvP.9ojLMjZdjPyZJ3ZhyoElbCoSP4qUVTmmm_cg8H43.5hFGdo
 SGlv3x44TOse_G.7_GrSDpkoBlWbgzQ5WH36.sc8cBoW6_tdeYLI6R13K2qFZujIwc5Y_W4.3THU
 .WgPjAnVbwd5vJa8mcKShlxL7Wr69sOIry9.d1o0m1yC0a.5WIE44VZoDM5Py9HmFYE4wVhyxoXC
 HLs1Zfrtpdc6a_2TmjWQCjVav4ipf1984xIVvrC2OMaWqVqxO3x5yZLer8oktcFBLFltBJIxB8Zc
 lKNNl3bElIWopzgL7C5loWLGmJrn_BzlthTau_GE4ArEWjR6ype.RYSXLJT5XX84Rn6wYiWtIE6m
 deF0d_dou3r14dIb_Pig-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:40:11 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb;
          Tue, 30 Mar 2021 00:40:07 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Fang Wei <fangwei1@huawei.com>,
        Guo Weichao <guoweichao@oppo.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, nl6720 <nl6720@gmail.com>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH 09/10] erofs: support decompress big pcluster for lz4 backend
Date:   Tue, 30 Mar 2021 08:39:07 +0800
Message-Id: <20210330003908.22842-10-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330003908.22842-1-hsiangkao@aol.com>
References: <20210330003908.22842-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Prior to big pcluster, there is only one compressed page so it'd
easy to map this. However, when big pcluster is enabled, more work
needs to be done to handle multiple compressed pages. In detail,

 - (maptype 0) if there is only one compressed page + no need
   to copy inplace I/O, just map it directly what we did before;

 - (maptype 1) if there are more compressed pages + no need to
   copy inplace I/O, vmap such compressed pages instead;

 - (maptype 2) if inplace I/O needs to be copied, use per-CPU
   buffers for decompression then.

Another thing is how to detect inplace decompression is feasable or
not (it's still quite easy for non big pclusters), apart from the
inplace margin calculation, inplace I/O page reusing order is also
needed to be considered for each compressed page. Currently, if the
compressed page is the xth page, it shouldn't be reused as [0 ...
nrpages_out - nrpages_in + x], otherwise a full copy will be triggered.

Although there are some extra optimization ideas for this, I'd like
to make big pcluster work correctly first and obviously it can be
further optimized later since it has nothing with the on-disk format
at all.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 202 ++++++++++++++++++++++++----------------
 1 file changed, 122 insertions(+), 80 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 5d9f9dbd3681..c7b1d3fe8184 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -116,44 +116,87 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	return kaddr ? 1 : 0;
 }
 
-static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
-				       u8 *src, unsigned int pageofs_in)
+static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
+			void *inpage, unsigned int *inputmargin, int *maptype,
+			bool support_0padding)
 {
-	/*
-	 * if in-place decompression is ongoing, those decompressed
-	 * pages should be copied in order to avoid being overlapped.
-	 */
-	struct page **in = rq->in;
-	u8 *const tmp = erofs_get_pcpubuf(1);
-	u8 *tmpp = tmp;
-	unsigned int inlen = rq->inputsize - pageofs_in;
-	unsigned int count = min_t(uint, inlen, PAGE_SIZE - pageofs_in);
-
-	while (tmpp < tmp + inlen) {
-		if (!src)
-			src = kmap_atomic(*in);
-		memcpy(tmpp, src + pageofs_in, count);
-		kunmap_atomic(src);
-		src = NULL;
-		tmpp += count;
-		pageofs_in = 0;
-		count = PAGE_SIZE;
+	unsigned int nrpages_in, nrpages_out;
+	unsigned int ofull, oend, inputsize, total, i, j;
+	struct page **in;
+	void *src, *tmp;
+
+	inputsize = rq->inputsize;
+	nrpages_in = PAGE_ALIGN(inputsize) >> PAGE_SHIFT;
+	oend = rq->pageofs_out + rq->outputsize;
+	ofull = PAGE_ALIGN(oend);
+	nrpages_out = ofull >> PAGE_SHIFT;
+
+	if (rq->inplace_io) {
+		if (rq->partial_decoding || !support_0padding ||
+		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
+			goto docopy;
+
+		for (i = 0; i < nrpages_in; ++i) {
+			DBG_BUGON(rq->in[i] == NULL);
+			for (j = 0; j < nrpages_out - nrpages_in + i; ++j)
+				if (rq->out[j] == rq->in[i])
+					goto docopy;
+		}
+	}
+
+	if (nrpages_in <= 1) {
+		*maptype = 0;
+		return inpage;
+	}
+	kunmap_atomic(inpage);
+	might_sleep();
+	while (1) {
+		src = vm_map_ram(rq->in, nrpages_in, -1);
+		/* retry two more times (totally 3 times) */
+		if (src || ++i >= 3)
+			break;
+		vm_unmap_aliases();
+	}
+	*maptype = 1;
+	return src;
+docopy:
+	/* Or copy compressed data which can be overlapped to per-CPU buffer */
+	in = rq->in;
+	src = erofs_get_pcpubuf(nrpages_in);
+	if (!src) {
+		DBG_BUGON(1);
+		return ERR_PTR(-EFAULT);
+	}
+
+	tmp = src;
+	total = rq->inputsize;
+	while (total) {
+		unsigned int page_copycnt =
+			min_t(unsigned int, total, PAGE_SIZE - *inputmargin);
+
+		if (!inpage)
+			inpage = kmap_atomic(*in);
+		memcpy(tmp, inpage + *inputmargin, page_copycnt);
+		kunmap_atomic(inpage);
+		inpage = NULL;
+		tmp += page_copycnt;
+		total -= page_copycnt;
 		++in;
+		*inputmargin = 0;
 	}
-	return tmp;
+	*maptype = 2;
+	return src;
 }
 
 static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 {
-	unsigned int inputmargin, inlen;
-	u8 *src;
-	bool copied, support_0padding;
-	int ret;
+	unsigned int inputmargin;
+	u8 *headpage, *src;
+	bool support_0padding;
+	int ret, maptype;
 
-	if (rq->inputsize > PAGE_SIZE)
-		return -EOPNOTSUPP;
-
-	src = kmap_atomic(*rq->in);
+	DBG_BUGON(*rq->in == NULL);
+	headpage = kmap_atomic(*rq->in);
 	inputmargin = 0;
 	support_0padding = false;
 
@@ -161,50 +204,39 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	if (erofs_sb_has_lz4_0padding(EROFS_SB(rq->sb))) {
 		support_0padding = true;
 
-		while (!src[inputmargin & ~PAGE_MASK])
+		while (!headpage[inputmargin & ~PAGE_MASK])
 			if (!(++inputmargin & ~PAGE_MASK))
 				break;
 
 		if (inputmargin >= rq->inputsize) {
-			kunmap_atomic(src);
+			kunmap_atomic(headpage);
 			return -EIO;
 		}
 	}
 
-	copied = false;
-	inlen = rq->inputsize - inputmargin;
-	if (rq->inplace_io) {
-		const uint oend = (rq->pageofs_out +
-				   rq->outputsize) & ~PAGE_MASK;
-		const uint nr = PAGE_ALIGN(rq->pageofs_out +
-					   rq->outputsize) >> PAGE_SHIFT;
-
-		if (rq->partial_decoding || !support_0padding ||
-		    rq->out[nr - 1] != rq->in[0] ||
-		    rq->inputsize - oend <
-		      LZ4_DECOMPRESS_INPLACE_MARGIN(inlen)) {
-			src = generic_copy_inplace_data(rq, src, inputmargin);
-			inputmargin = 0;
-			copied = true;
-		}
+	rq->inputsize -= inputmargin;
+	src = z_erofs_handle_inplace_io(rq, headpage, &inputmargin, &maptype,
+					support_0padding);
+	if (IS_ERR(src)) {
+		kunmap_atomic(headpage);
+		return PTR_ERR(src);
 	}
 
 	/* legacy format could compress extra data in a pcluster. */
 	if (rq->partial_decoding || !support_0padding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
-						  inlen, rq->outputsize,
-						  rq->outputsize);
+				rq->inputsize, rq->outputsize, rq->outputsize);
 	else
 		ret = LZ4_decompress_safe(src + inputmargin, out,
-					  inlen, rq->outputsize);
+					  rq->inputsize, rq->outputsize);
 
 	if (ret != rq->outputsize) {
 		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
-			  ret, inlen, inputmargin, rq->outputsize);
+			  ret, rq->inputsize, inputmargin, rq->outputsize);
 
 		WARN_ON(1);
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, src + inputmargin, inlen, true);
+			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, out, rq->outputsize, true);
 
@@ -213,10 +245,16 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		ret = -EIO;
 	}
 
-	if (copied)
-		erofs_put_pcpubuf(src);
-	else
+	if (maptype == 0) {
 		kunmap_atomic(src);
+	} else if (maptype == 1) {
+		vm_unmap_ram(src, PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT);
+	} else if (maptype == 2) {
+		erofs_put_pcpubuf(src);
+	} else {
+		DBG_BUGON(1);
+		return -EFAULT;
+	}
 	return ret;
 }
 
@@ -268,33 +306,37 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	void *dst;
 	int ret, i;
 
-	if (nrpages_out == 1 && !rq->inplace_io) {
-		DBG_BUGON(!*rq->out);
-		dst = kmap_atomic(*rq->out);
-		dst_maptype = 0;
-		goto dstmap_out;
-	}
+	/* two optimized fast paths only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE) {
+		if (nrpages_out == 1 && !rq->inplace_io) {
+			DBG_BUGON(!*rq->out);
+			dst = kmap_atomic(*rq->out);
+			dst_maptype = 0;
+			goto dstmap_out;
+		}
 
-	/*
-	 * For the case of small output size (especially much less
-	 * than PAGE_SIZE), memcpy the decompressed data rather than
-	 * compressed data is preferred.
-	 */
-	if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
-		dst = erofs_get_pcpubuf(1);
-		if (IS_ERR(dst))
-			return PTR_ERR(dst);
-
-		rq->inplace_io = false;
-		ret = alg->decompress(rq, dst);
-		if (!ret)
-			copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
-					  rq->outputsize);
-
-		erofs_put_pcpubuf(dst);
-		return ret;
+		/*
+		 * For the case of small output size (especially much less
+		 * than PAGE_SIZE), memcpy the decompressed data rather than
+		 * compressed data is preferred.
+		 */
+		if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
+			dst = erofs_get_pcpubuf(1);
+			if (IS_ERR(dst))
+				return PTR_ERR(dst);
+
+			rq->inplace_io = false;
+			ret = alg->decompress(rq, dst);
+			if (!ret)
+				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
+						  rq->outputsize);
+
+			erofs_put_pcpubuf(dst);
+			return ret;
+		}
 	}
 
+	/* general decoding path which can be used for all cases */
 	ret = alg->prepare_destpages(rq, pagepool);
 	if (ret < 0) {
 		return ret;
-- 
2.20.1

